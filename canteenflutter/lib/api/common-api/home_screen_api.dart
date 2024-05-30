import 'dart:convert';
import 'package:canteenflutter/config/config.dart';
import 'package:http/http.dart' as http;

class HomeProductDisplayApiCommon {
  static List<AddedProductData> addedproductdata = [];
  static displayAddedProductInVendorandUser() async {
    try {
      final res = await http.get(Uri.parse(getAddedProductData));
      // print(res.statusCode);

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body);
        addedproductdata = jsonData
            .map((data) => AddedProductData(
                  id: data['_id'],
                  proname: data['proName'],
                  proprice: data['proPrice'],
                  proDesc: data['proDesc'],
                  proQuantity: data['proQuantity'],
                  proCategory: data['proCategory'],
                ))
            .toList();
        return addedproductdata;
      }
    } catch (e) {
     rethrow;
    }
  }
}

class AddedProductData {
  String proname;
  int proprice;
  String id = "";
  String proDesc = "";
  String proQuantity = "";
  String proCategory = "";

  AddedProductData({
    required this.proname,
    required this.proprice,
    required this.id,
    required this.proDesc,
    required this.proQuantity,
    required this.proCategory,
  });
}
