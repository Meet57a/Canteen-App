import 'package:canteenflutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateCategoryApiVendor {
  static void createCat(category, context) async {
    try {
      final res = await http.post(
        Uri.parse(createCategory),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {"categoryName": category},
        ),
      );

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Category Created")));
      } else if (res.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Category Already Exist")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something went wrong")));
      }
    } catch (e) {
      rethrow;
    }
  }
}
