// import 'dart:convert';

import 'package:canteenflutter/api/user-side-api/auth_api.dart';
import 'package:canteenflutter/constants/image_string.dart';
import 'package:canteenflutter/exceptions/user-side/login_screen.dart';
import 'package:canteenflutter/pages/user-side/auth/forget_password.dart';
import 'package:canteenflutter/pages/user-side/auth/sign_up_screen.dart';
import 'package:canteenflutter/pages/user-side/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fullName = TextEditingController();
  final eMail = TextEditingController();
  final passWord = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
    // cousname = widget.coustomername;
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future setData(token, user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('email', user.email);
    prefs.setString('fullName', user.displayName!);
    prefs.setString('userId', user.id);
  }

  

  @override
  Widget build(BuildContext context) {
    final loginformKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: const Color(0xfff65b08),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    // const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(userImg),
                    ),
                    // const SizedBox(height: 20),
                    Container(
                      height: 590,
                      width: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 15,
                            offset: const Offset(
                                0, 3), // changes position of shadow
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
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
                                              color: Color(0xfff65b08),
                                              width: 2),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'E-Mail',
                                        hintStyle: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 20),
                                      ),
                                      validator:
                                          UserSideException.validateEmail,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
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
                                              color: Color(0xfff65b08),
                                              width: 2),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 20),
                                      ),
                                      validator:
                                          UserSideException.validatePassword,
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
                                                const ForgetScreen()));
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
                                  AuthUser.loginUser(
                                      eMail, passWord, prefs, context);
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
                          const SizedBox(height: 20),
                          const Text(
                            'OR',
                            style:
                                TextStyle(fontSize: 20, color: Colors.blueGrey),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 60,
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () async {
                                var user = await AuthUser.login();
                                if (user != null) {
                                  String token = await user.authentication
                                      .then((auth) => auth.accessToken!);

                                  setData(token, user);

                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreenUser()),
                                      (route) => false).then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text("Login In Success"),
                                      ),
                                    ),
                                  );
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Login In Fail"),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff053f5c),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          child: Image.asset(googleImg),
                                        ),
                                        const Text(
                                          'Sign In With Google',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Not have an account?',
                                style: TextStyle(
                                    color: Colors.black26, fontSize: 15),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                },
                                child: const Text(
                                  ' Sign Up ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xff03a0e4)),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
