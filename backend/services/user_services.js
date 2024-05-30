const UserModel = require("../model/user_model");
const OtpModel = require("../model/otp_model");
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');


class UserService {
    static async registerUser(fullName, email, password, type) {
        try {



            const createUser = new UserModel({ fullName, email, password, type });
            return await createUser.save();

        } catch (err) {
            throw err;
        }
    }

    static async userCheck(email, password) {
        try {
            return await UserModel.findOne({ email });
        } catch (err) {
                if (err) {
                    res.send(false);
                }
        }
    }
    static async generateToken(tokenData, secretKey, jwt_expire) {
        return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });

    }

    static async forgetPasswordRequestAndSendMail(email, res) {

        const existsUser = await UserModel.findOne({ email });

        const transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: 'meetsenjaliya01@gmail.com', // Replace with your Gmail email address
                pass: 'wkyc eqah yhuc jvey', // Replace with your Gmail password
            },
        });
        const otp = Math.floor(1000 + Math.random() * 9000);

        if (existsUser) {
            try {
                await OtpModel.create({ email, otp });

                const mailOptions = {
                    from: 'meetsenjaliya01@gmail.com',
                    to: email,
                    subject: 'Password Reset OTP',
                    text: `Your OTP for password reset is ${otp}`,
                };

                transporter.sendMail(mailOptions, (error, info) => {
                    if (error) {
                        return res.status(500).send({ message: 'Failed to send OTP.' });
                    } else {
                        return res.send({ message: 'OTP sent successfully.' });
                    }
                });

            } catch (error) {

                return res.status(500).json({ message: 'Failed to store OTP.' });
            }
        }
    }

    static async otpVerify(otp, storedOtp, res) {

        try {
            if (otp == storedOtp) {
                res.json({ message: 'OTP verification successful. You can now reset your password.' });
            } else {
                res.status(400).json({ message: 'Invalid OTP.' });
            }
        } catch (error) {
            console.error(error);
            res.status(500).json({ message: 'An unexpected error occurred.' });
        }
    }

    static async changePassword(email, password,res) {
        try {
            const user = await UserModel.findOne({ email });
            if (user) {
                // let hashedPassword = await bcrypt.hashSync(password, 10);
                // console.log(hashedPassword);
                user.password = password;
                await user.save();
                
            }

            await OtpModel.deleteOne({ email });
            res.status(400).json({ message: 'Password changed successfully.' })
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: 'An unexpected error occurred.' });
        }
    }
}

module.exports = UserService;