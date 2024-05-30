import 'package:canteenflutter/pages/vendor-side/auth/login_screen.dart';
import 'package:canteenflutter/pages/vendor-side/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginToHomeScreenVendor {
  static void loginToHomeScreenVendor(myToken, context) {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(myToken);
    var type = jwtDecodedToken['type'];
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) =>
                (JwtDecoder.isExpired(myToken) == false && type == "isVendor")
                    ? const HomeScreenVendor()
                    : const LoginScreenVendor()),
        (Route<dynamic> route) => false);
  }
}
