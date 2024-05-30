import 'dart:convert';
import 'package:canteenflutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddToCartProductApiUser {
  static void addToCart(proName, totalprice, cabinno, proQuntaty, productId,
      productPrice, userId,context) async {
    if (proName.isNotEmpty && totalprice != 0 && cabinno.isNotEmpty) {
      var regBody = {
        "productName": proName,
        "totalPrice": totalprice,
        "cabinNo": cabinno,
        "productQuantaty": proQuntaty,
        "productId": productId,
        "productPrice": productPrice,
        "userId": userId
      };
      var response = await http.post(
        Uri.parse(addtocart),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Your product is added to cart")));
      } 
    }
  }
}
