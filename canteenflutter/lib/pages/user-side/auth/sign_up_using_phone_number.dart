import 'package:canteenflutter/constants/image_string.dart';
import 'package:canteenflutter/pages/user-side/auth/login_screen.dart';
import 'package:canteenflutter/pages/user-side/auth/otp_screen.dart';
import 'package:canteenflutter/pages/user-side/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';


  class SignUpUsingPhoneNoScreen extends StatelessWidget {
    const SignUpUsingPhoneNoScreen({Key? key}) : super(key: key);

    @override
      Widget build(BuildContext context) {
    
      final phonekey = GlobalKey<FormState>();

      // ignore: prefer_typing_uninitialized_variables
      var phoneNo;
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 841.21,
                width: 410.5,
                color: const Color(0xfff65b08),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 225,
                      child: Image.asset(logo),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 340,
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
                            padding: EdgeInsets.only(left: 25, top: 20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                    Text(
                                      'Sign Up using phone number.',
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 18, right: 200, bottom: 5),
                            child: Text(
                              'Enter Phone No',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Form(
                            key: phonekey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: SizedBox(
                                width: 300,
                                height: 60,
                                child: TextField(
                                  controller: phoneNo,
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
                                    hintText: 'Phone No',
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 115, bottom: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUpScreen()));
                              },
                              child: const Text(
                                'Sign Up using E-mail address',
                                style: TextStyle(
                                  color: Color(0xff03a0e4),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () {
                                if (phonekey.currentState!.validate()) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const OtpScreenUser(email: null,)));
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
                                'Get otp',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 15),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const LoginScreen()));
                                },
                                child: const Text(
                                  ' Sign In ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
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
              )
            ],
          ),
        ),
      );
    }
  }
