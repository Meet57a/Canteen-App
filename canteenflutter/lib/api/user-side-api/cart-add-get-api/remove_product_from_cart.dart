import 'package:canteenflutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteCartDataApiUser {
  static deleteCartDataUser(id, context) async {
    // print(id);
    final res = await http.post(Uri.parse("${url}deleteCartProduct/$id"));
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product Removed From Cart")));
    } else {
      throw Exception('Failed to delete data');
    }
  }
}
