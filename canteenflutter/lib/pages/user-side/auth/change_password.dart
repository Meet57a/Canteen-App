import 'package:canteenflutter/api/user-side-api/auth_api.dart';
import 'package:canteenflutter/constants/image_string.dart';
import 'package:canteenflutter/exceptions/user-side/login_screen.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final email;
  const ChangePasswordScreen({super.key, @required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final createNewPassword = TextEditingController();
    final confirmPassword = TextEditingController();

    final loginformKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 841.21,
              width: 410.5,
              color: const Color(0xfff65b08),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset(userImg),
                        ),
                        SizedBox(
                          height: 200,
                          child: Image.asset(logo),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 300,
                      width: 350,
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
                            padding:
                                EdgeInsets.only(top: 18, right: 176, bottom: 5),
                            child: Text(
                              'Enter new password',
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
                                      controller: createNewPassword,
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
                                        hintText: 'Enter new password',
                                        hintStyle: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 20),
                                      ),
                                      validator:
                                          UserSideException.validatePassword,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 18, right: 204, bottom: 5),
                                  child: Text(
                                    'Enter password again',
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
                                      controller: confirmPassword,
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
                                        hintText: 'Enter password again',
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
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 60,
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () {
                                if (loginformKey.currentState!.validate()) {
                                  if (createNewPassword.text ==
                                      confirmPassword.text) {
                                    AuthUser.updatePassword(widget.email,
                                        createNewPassword, context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please Enter Same Password In Both")));
                                  }
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
            ),
          ],
        ),
      ),
    );
  }
}
