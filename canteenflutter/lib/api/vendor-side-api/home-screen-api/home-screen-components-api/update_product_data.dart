import 'dart:convert';

import 'package:canteenflutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateProductDataApiVendor {
  static updateProduct(id, body, context) async {
    // print(id);

    final res = await http.post(Uri.parse("${url}updateProduct/$id"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body));

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Product Updated")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to update product")));
    }
  }
}
