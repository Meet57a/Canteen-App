import 'package:flutter/material.dart';
import 'package:canteenflutter/pages/common-side/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // ignore: prefer_typing_uninitialized_variables
  final fakeToken;
  final String? token;
  String? fakeType;
  var type = prefs.getString('type');
  
  token = prefs.getString("token");
  if (token == null && type == null) {
    fakeToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
    fakeType = "Dontexists";
  } else {
    fakeToken = token;
    fakeType = type;
  }

  runApp(MyApp(
    token: fakeToken,
    type: fakeType,
  ));
}

class MyApp extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  // ignore: prefer_typing_uninitialized_variables
  final type;

  const MyApp({Key? key, this.token, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(token: token, type: type),
    );
  }
}
