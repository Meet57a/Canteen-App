import 'package:canteenflutter/pages/user-side/auth/login_screen.dart';
import 'package:canteenflutter/pages/user-side/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff65b08),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 1.3),
            Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(5, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to ',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Student Cafe',
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xfff65b08),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff053f5c),
                            shadowColor: Colors.black,
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
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
