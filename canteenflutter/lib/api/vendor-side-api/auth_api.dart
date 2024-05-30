import 'dart:convert';
import 'package:canteenflutter/exceptions/vendor-side/login_screen.dart';
import 'package:canteenflutter/pages/vendor-side/auth/login_screen.dart';

import 'package:canteenflutter/routing/vendor_routing.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:canteenflutter/config/config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthVendor {
  static void loginUserVendor(eMail, passWord, context, prefs) async {
    var reqBody = {"email": eMail.text, "password": passWord.text};

    var response = await http.post(
      Uri.parse(loginVendor),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    var jsonResponse = jsonDecode(response.body);

    LoginScreenExceptionVendor.isCredentialValid(
        jsonResponse['message'], context);

    if (jsonResponse['status']) {
      var myToken = jsonResponse['token'];
      prefs.setString('token', myToken);
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(myToken);
      var email = jwtDecodedToken['email'];
      var userName = jwtDecodedToken['fullName'];
      var userId = jwtDecodedToken['_id'];
      var type = jwtDecodedToken['type'];
      prefs.setString('email', email);
      prefs.setString('fullName', userName);
      prefs.setString('userId', userId);
      prefs.setString('type', type);

      LoginToHomeScreenVendor.loginToHomeScreenVendor(myToken, context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('User logged in successfully')));
    }
  }

  static Future<void> logoutUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreenVendor()),
        (Route<dynamic> route) => false);
  }
}
