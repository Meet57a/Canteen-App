const router = require('express').Router();
const UserController = require("../controller/user_controller");
const VendorController = require("../controller/vendor_controller");

router.post('/registration', UserController.register);
router.post('/loginUser', UserController.loginUser);
router.post('/loginVendor', VendorController.loginVendor);
router.post('/forgetPasswordRequestAndSendOtp', UserController.forgetPasswordRequestAndSendMail);
router.post('/verifyOtp', UserController.verifyOtp);
router.post('/changePassword', UserController.updatePassword);


module.exports = router;

