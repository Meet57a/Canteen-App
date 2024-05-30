import 'package:flutter/material.dart';

class UserSideException {
  static String? validateEmail(String? value) {
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

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 8) {
      return "Password must be have minimum 8 letters";
    } else if (value.length > 10) {
      return "Password cannot be have greter than 10 letters";
    }
    return null;
  }

  static void isCredentialValid(message, context) {
    if (message == "Email not found.") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This email is not registered.')));
    } else if (message == 'Invalid password') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid password')));
    } else if (message == 'You are not a User') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('You are not a User')));
    }
  }

  static void isCredentialValidOrOtpSend(jsonResponse, context, response) {
    if (jsonResponse['message'] == "This Email does not exist.") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This Email does not exist.")));
    }

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("OTP sent successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to send OTP")));
    }
  }

  static void isOtpMatch(response, context) {
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Otp Verified Successfully.")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Otp Doesn't Match.")));
    }
  }
}
