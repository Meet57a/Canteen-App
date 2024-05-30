import 'dart:convert';

import 'package:canteenflutter/config/config.dart';
import 'package:http/http.dart' as http;

class GetOrderedDataToUser {
  static getOrderProduct(userId) async {
    List<GetOrderedData> product = [];
    try {
      final res = await http.post(
        Uri.parse(getOrderedProductToUserScreen),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}),
      );
      // print(res.statusCode);
      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body);

        product = jsonData
            .map((data) => GetOrderedData(
                  orderId: data['_id'],
                  coustomerName: data['CustomerName'],
                  proname: data['proName'],
                  proprice: data['proPrice'],
                  cabinno: data['cabinno'],
                  productId: data['productId'],
                  userId: data['userId'],
                ))
            .toList();

        return product;
        // print(jsonData);
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}

class GetOrderedData {
  final String proname;
  final int proprice;
  final String cabinno;
  final String coustomerName;
  String productId;
  String userId;
  String orderId;
  GetOrderedData({
    required this.proname,
    required this.proprice,
    required this.cabinno,
    required this.coustomerName,
    required this.productId,
    required this.userId,
    required this.orderId,
  });
}
