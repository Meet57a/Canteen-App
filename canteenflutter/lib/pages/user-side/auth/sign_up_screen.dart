import 'package:canteenflutter/api/user-side-api/auth_api.dart';
import 'package:canteenflutter/constants/image_string.dart';
import 'package:canteenflutter/pages/user-side/auth/login_screen.dart';
import 'package:canteenflutter/pages/user-side/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullName = TextEditingController();
  final eMail = TextEditingController();
  final passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? value) {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value!.isEmpty || !regex.hasMatch(value)
          ? 'Enter a valid email address'
          : null;
    }

    Future setData(token, user) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setString('email', user.email);
      prefs.setString('fullName', user.displayName!);
      prefs.setString('userId', user.id);
    }

    final formkey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xfff65b08),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    // width: 100,
                    child: Image.asset(userImg),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 650,
                    width: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20, right: 200),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2, right: 25),
                          child: Text(
                            'Create your profile to start your journey',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 18, right: 206, bottom: 5),
                          child: Text(
                            'Enter full name',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Form(
                          key: formkey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: SizedBox(
                                  width: 300,
                                  height: 60,
                                  child: TextFormField(
                                    controller: fullName,
                                    obscureText: false,
                                    cursorColor: Colors.blueGrey,
                                    cursorHeight: 25,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xfff65b08),
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xfff65b08), width: 2),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Full Name',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 20),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Value Can't Be Empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 10, right: 176, bottom: 5),
                                child: Text(
                                  'Enter email address',
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
                                    validator: validateEmail,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 10, right: 204, bottom: 5),
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please create your password";
                                      } else if (value.length < 8) {
                                        return "Password must be have minimum 8 letters";
                                      } else if (value.length > 10) {
                                        return "Password cannot be have greter than 10 letters";
                                      }
                                      return null;
                                    },
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
                              if (formkey.currentState!.validate()) {
                                AuthUser.registerUser(
                                    fullName, eMail, passWord, context);
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
                              'Sign up',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'OR',
                          style: TextStyle(fontSize: 20, color: Colors.black38),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 60,
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff053f5c),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Login In Fail"),
                                        ),
                                      );
                                    }
                                  },
                                  child: SizedBox(
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
                              'Already have an account?',
                              style: TextStyle(
                                  color: Colors.black26, fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
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
            ),
          ],
        ),
      ),
    );
  }
}
