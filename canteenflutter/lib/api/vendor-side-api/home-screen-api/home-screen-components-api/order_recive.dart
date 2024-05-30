import 'dart:convert';

import 'package:canteenflutter/config/config.dart';
import 'package:http/http.dart' as http;

class OrderRecivedApiVendor {
  static getOrderProduct() async {
    List<OrderRecivedData> product = [];
    try {
      final res = await http.get(Uri.parse(getOrderedProductData));
      // print(res.statusCode);
      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body);

        product = jsonData
            .map((data) => OrderRecivedData(
                  coustomerName: data['CustomerName'],
                  proname: data['proName'],
                  proprice: data['proPrice'],
                  cabinno: data['cabinno'],
                  productId:data['productId'],
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

class OrderRecivedData {
  final String proname;
  final int proprice;
  final String cabinno;
  final String coustomerName;
  String productId;

  OrderRecivedData({
    required this.proname,
    required this.proprice,
    required this.cabinno,
    required this.coustomerName,
    required this.productId,
  });
}
