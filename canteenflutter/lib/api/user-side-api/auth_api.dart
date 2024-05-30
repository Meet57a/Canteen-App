// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:canteenflutter/config/config.dart';
import 'package:canteenflutter/exceptions/user-side/login_screen.dart';
import 'package:canteenflutter/pages/user-side/auth/login_screen.dart';
import 'package:canteenflutter/routing/user_routing.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUser {
  static void registerUser(fullName, eMail, passWord, context) async {
    if (eMail.text.isNotEmpty && passWord.text.isNotEmpty) {
      // print(eMail);
      var regBody = {
        "fullName": fullName.text,
        "email": eMail.text,
        "password": passWord.text,
        "type": "isUser",
      };

      var response = await http.post(
        Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['message'] == "Email already exists.") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email already exists.')));
      }

      if (jsonResponse['status']) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        print("somthing went wrong.");
      }
    } else {
      print("Nothing");
    }
  }

  static void loginUser(eMail, passWord, prefs, context) async {
    var reqBody = {"email": eMail.text, "password": passWord.text};

    var response = await http.post(
      Uri.parse(loginuser),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    var jsonResponse = jsonDecode(response.body);
    UserSideException.isCredentialValid(jsonResponse['message'], context);
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
      UserAppRouting.loginToHomeScreenUser(myToken, context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User logged in successfully')));
    } else {
      print('Something  went wrong');
    }
  }

  static void forgetPasswordRequestAndSendOtp(email, context) async {
    var reqBody = {"email": email.text};
    try {
      var response = await http.post(
        Uri.parse(userForgetPasswordRequest),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      var jsonResponse = jsonDecode(response.body);

      UserSideException.isCredentialValidOrOtpSend(
          jsonResponse, context, response);

      UserAppRouting.forgetPassPageToOtpPage(response, context, email);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An unexpected error occurred")));
    }
  }

  static void verifyOtpUserSide(email, otp, context) async {
    var reqBody = {"email": email.text, "otp": otp};

    try {
      var response = await http.post(
        Uri.parse(verifyOtpUser),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );


      // print(jsonResponse['message']);
      UserSideException.isOtpMatch(response, context);

      UserAppRouting.otpPageToChangePassword(response, context, email);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An unexpected error occurred")));
    }
  }

  static void updatePassword(email, password, context) async {
    var reqBody = {"email": email.text, "password": password.text};

    try {
      var response = await http.post(
        Uri.parse(changePassword),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      // print(jsonResponse['message']);

      // print(response.statusCode);

      if (response.statusCode == 400) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password changed successfully")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An unexpected error occurred")));
    }
  }

  static Future<void> logoutUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false);
  }

  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

// class AuthHelper {
//   static const String _isLoggedInKey = 'isLoggedIn';

//   static Future<bool> isLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_isLoggedInKey) ?? false;
//   }

//   static Future<void> logIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_isLoggedInKey, true);
//   }

//   static Future<void> logOut() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_isLoggedInKey, false);
//   }
// }
