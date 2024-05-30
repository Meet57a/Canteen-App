import 'dart:convert';
import 'package:canteenflutter/config/config.dart';
import 'package:http/http.dart' as http;

class GetAddedToCartProductApiUser {
  static List<AddedProductInCartData> getaddedproductincart = [];
  static displayAddedProductInVendorandUser(userId) async {
    try {
      final res = await http.post(
        Uri.parse(getAddedProductInCart),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}),
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body);
        getaddedproductincart = jsonData
            .map((data) => AddedProductInCartData(
                  productId: data['productId'],
                  productName: data['productName'],
                  totalPrice: data['totalPrice'],
                  cabinNo: data['cabinNo'],
                  proQuantity: data['productQuantaty'],
                  productPrice: data['productPrice'],
                  id: data['_id'],
                ))
            .toList();
        return getaddedproductincart;
      }
    } catch (e) {
      rethrow;
    }
  }
}

class AddedProductInCartData {
  String id;
  String productId;
  String productName;
  int totalPrice;
  String cabinNo;
  int proQuantity;
  int productPrice;

  AddedProductInCartData({
    required this.productId,
    required this.productName,
    required this.totalPrice,
    required this.cabinNo,
    required this.proQuantity,
    required this.productPrice,
    required this.id,
  });
}
