import 'package:canteenflutter/pages/user-side/auth/change_password.dart';
import 'package:canteenflutter/pages/user-side/auth/login_screen.dart';
import 'package:canteenflutter/pages/user-side/auth/otp_screen.dart';
import 'package:canteenflutter/pages/user-side/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserAppRouting {
  static void loginToHomeScreenUser(myToken, context) {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(myToken);
    var type = jwtDecodedToken['type'];
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) =>
                (JwtDecoder.isExpired(myToken) == false && type == "isUser")
                    ? const HomeScreenUser()
                    : const LoginScreen()),
        (Route<dynamic> route) => false);
  }

  static void forgetPassPageToOtpPage(response, context, email) {
    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OtpScreenUser(email: email)));
    }
  }

  static void otpPageToChangePassword(response, context, email) {
    if (response.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(
                    email: email,
                  )));
    }
  }
}
