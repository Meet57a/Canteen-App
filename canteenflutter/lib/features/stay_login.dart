import 'dart:async';
import 'package:canteenflutter/pages/common-side/select_vendor_user.dart';
import 'package:canteenflutter/pages/user-side/home_screen.dart';
import 'package:canteenflutter/pages/vendor-side/home_screen.dart';
import 'package:flutter/material.dart';

class IsLoggedIn {
  static void isUserLoggedIn(token, type, context) async {

    String fakeToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
    String fakeType = "Dontexists";
    String isVendor = "isVendor";
    Timer(
      const Duration(seconds: 2),
      () {
        if (type == isVendor) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => (token == fakeToken && type == fakeType)
                      ? const SelectUserOrVendor()
                      : const HomeScreenVendor()),
              (route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => (token == fakeToken && type == fakeType)
                      ? const SelectUserOrVendor()
                      : const HomeScreenUser()),
              (route) => false);
        }
      },
    );
  }
}
