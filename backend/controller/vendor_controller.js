const UserService = require('../services/user_services');
const comparePassword = require("../lib/comparePassword")

exports.loginVendor = async (req, res, next) => {

    try {
        const { email, password } = req.body;

        const user = await UserService.userCheck(email);
        // console.log("---------user---------", user);
        if (!user) return res.status(401).send({ auth: false, message: 'Email not found.' })

        const isMatch = await comparePassword(password, user.password);

        if (isMatch === false) {
            return res.status(401).send({ auth: false, message: 'Invalid password' });

        }
        if (user.type != "isVendor") {
            return res.status(401).send({ auth: false, message: 'You are not a Vendor' });
        }
        let tokenData = { _id: user._id, email: user.email, fullName: user.fullName, type: user.type };

        const token = await UserService.generateToken(tokenData, "secretKey", '1h')
        res.status(200).json({ status: true, token: token });
    } catch (err) {
        throw err
    }
}