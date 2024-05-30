const { status } = require('express/lib/response');
const UserService = require('../services/user_services');
const comparePassword = require("../lib/comparePassword");
const OtpModel = require("../model/otp_model");

    
exports.register = async (req, res, next) => {
    try {
        const { fullName, email, password, type } = req.body;
        const user = await UserService.userCheck(email);

        if (user) {
            return res.status(401).send({ auth: false, message: 'Email already exists.' });
        } else {
            const successRes = await UserService.registerUser(fullName, email, password, type);
            res.json({ status: true, success: "User Registered Successfully" });
        }
    } catch (err) {
        throw err
    }
}
exports.loginUser = async (req, res, next) => {
    // console.log(req.body)

    try {
        const { email, password } = req.body;
        const user = await UserService.userCheck(email);

        if (!user) return res.status(401).send({ auth: false, message: 'Email not found.' })

        const isMatch = await comparePassword(password, user.password);

        if (isMatch === false) {
            return res.status(401).send({ auth: false, message: 'Invalid password' });

        }
        if (user.type != "isUser") {
            return res.status(401).send({ auth: false, message: 'You are not a User' });
        }

        let tokenData = { _id: user._id, email: user.email, fullName: user.fullName, type: user.type };

        const token = await UserService.generateToken(tokenData, "secretKey", '1h')
        res.status(200).json({ status: true, token: token });
    } catch (err) {
        throw err
    }
}
exports.forgetPasswordRequestAndSendMail = async (req, res) => {
    try {
        const { email } = req.body;

        const user = await UserService.userCheck(email);
        if (user) {
            const sendEmail = await UserService.forgetPasswordRequestAndSendMail(email, res);
            res.json({ status: true, success: sendEmail });
        } else {
            res.status(403).json({ status: false, message: "This Email does not exist." });
        }

    } catch (error) {
        throw error;
    }
}

exports.verifyOtp = async (req, res) => {
    try {
        const { email, otp } = req.body;
        const otpData = await OtpModel.findOne({ email }, {}, { sort: { timestamp: -1 } });
        const storedOtp = otpData.otp;
        if (!otpData) {
            return res.status(400).json({ message: 'Email not found.' });
        } else {

            const sendEmail = await UserService.otpVerify(otp, storedOtp, res);
        }
    } catch (error) {
        throw error;
    }
}

exports.updatePassword = async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = UserService.userCheck(email);
        if (user) {
            const updateUser = UserService.changePassword(email, password,res);
            // console.log(req.body);
        } else {
            return res.status(406).send({ message: "Invalid request" });
        }
    } catch (error) {

    }
}

setInterval(async () => {
    const expirationTime = 30 * 1000;

    try {
        const result = await OtpModel.deleteMany({ timestamp: { $lt: new Date(Date.now() - expirationTime) } });
        console.log(`Expired OTPs removed: ${result.deletedCount}`);
    } catch (error) {
        console.error('Failed to remove expired OTPs:', error);
    }
}, 5 * 60 * 1000);