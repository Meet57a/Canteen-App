// import 'dart:convert';
import 'package:canteenflutter/api/vendor-side-api/auth_api.dart';
import 'package:canteenflutter/constants/image_string.dart';
import 'package:canteenflutter/exceptions/vendor-side/login_screen.dart';

import 'package:canteenflutter/pages/vendor-side/auth/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class LoginScreenVendor extends StatefulWidget {
  const LoginScreenVendor({Key? key}) : super(key: key);

  @override
  State<LoginScreenVendor> createState() => _LoginScreenVendor();
}

class _LoginScreenVendor extends State<LoginScreenVendor> {
  final fullName = TextEditingController();
  final eMail = TextEditingController();
  final passWord = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final loginformKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xfff65b08),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(vendorImg),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 460,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20, right: 225),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2, right: 125),
                          child: Text(
                            'Please login to sign in',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 18, right: 176, bottom: 5),
                          child: Text(
                            'Enter email address',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Form(
                          key: loginformKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: SizedBox(
                                  width: 300,
                                  height: 60,
                                  child: TextFormField(
                                    controller: eMail,
                                    obscureText: false,
                                    cursorColor: Colors.blueGrey,
                                    cursorHeight: 25,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xfff65b08)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xfff65b08), width: 2),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'E-Mail',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 20),
                                    ),
                                    validator: LoginScreenExceptionVendor
                                        .validateEmail,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 18, right: 204, bottom: 5),
                                child: Text(
                                  'Enter password',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: SizedBox(
                                  width: 300,
                                  height: 60,
                                  child: TextFormField(
                                    controller: passWord,
                                    obscureText: false,
                                    cursorColor: Colors.blueGrey,
                                    cursorHeight: 25,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xfff65b08)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xfff65b08), width: 2),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 20),
                                    ),
                                    validator: LoginScreenExceptionVendor
                                        .validatePassword,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgetPasswordVendorScreen()));
                                },
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 60,
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              if (loginformKey.currentState!.validate()) {
                                AuthVendor.loginUserVendor(
                                    eMail, passWord, context, prefs);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xfff65b08),
                              shadowColor: Colors.black,
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
