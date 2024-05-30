import 'package:canteenflutter/features/stay_login.dart';
import 'package:flutter/material.dart';
import 'package:canteenflutter/constants/image_string.dart';

class SplashScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  // ignore: prefer_typing_uninitialized_variables
  final type;
  const SplashScreen({
    Key? key,
    this.token,
    this.type,
  }) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final token = widget.token;
    final type = widget.type;

    IsLoggedIn.isUserLoggedIn(token, type, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xfff65b08),
            child: Center(
              child: Image.asset(
                logo,
                height: 200,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
