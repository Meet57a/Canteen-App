import 'package:canteenflutter/api/user-side-api/auth_api.dart';
import 'package:canteenflutter/exceptions/vendor-side/login_screen.dart';
import 'package:canteenflutter/pages/user-side/auth/login_screen.dart';
import 'package:flutter/material.dart';
import '../../../constants/image_string.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 841.21,
          width: 410.5,
          color: const Color(0xfff65b08),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: 240,
                  child: Image.asset(logo),
                ),
                const SizedBox(height: 25),
                Container(
                  height: 360,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 15,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 25, right: 83),
                        child: Text(
                          'Forget your password',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, left: 25),
                        child: Text(
                          'Please enter the email address you\'d like your password reset information sent to',
                          style: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30, right: 176),
                        child: Text(
                          'Enter email address',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: SizedBox(
                          width: 300,
                          height: 60,
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              controller: email,
                              obscureText: false,
                              cursorColor: Colors.blueGrey,
                              cursorHeight: 25,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xfff65b08)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xfff65b08), width: 2),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'E-Mail',
                                hintStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 20),
                              ),
                              validator:
                                  LoginScreenExceptionVendor.validateEmail,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthUser.forgetPasswordRequestAndSendOtp(
                                  email, context);
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
                            'Reset my password',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          'Back to login',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
