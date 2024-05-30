import 'dart:convert';

import 'package:canteenflutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderProductApiUser {
  static void orderproductany(fullname, proName, totalprice, cabinno, email,
      proQuntaty, productId, context, userId) async {
    if (proName.isNotEmpty && totalprice != 0 && cabinno.isNotEmpty) {
      var regBody = {
        "email": email,
        "CustomerName": fullname,
        "proName": proName,
        "proPrice": totalprice,
        "cabinno": cabinno,
        "productQuantaty": proQuntaty,
        "productId": productId,
        "userId": userId
      };
      var response = await http.post(
        Uri.parse(orderpro),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Your Order is Placed")));
      }
    }
  }
}
