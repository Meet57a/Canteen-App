import 'dart:convert';
import 'package:canteenflutter/config/config.dart';
import 'package:http/http.dart' as http;

class GetStoredProductDataShortedByCategory {
  static List<GetAddedProductDataCategoryWiseData> product = [];
  static getProductDataCategoryWise(category) async {
    try {
      final res = await http.post(
        Uri.parse(getAddedProductDataCategoryWise),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"proCategory": category}),
      );


      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body);

        product = jsonData
            .map((data) => GetAddedProductDataCategoryWiseData(
                  proname: data['proName'],
                  proprice: data['proPrice'],
                  proqty: data['proQuantity'],
                  procategory: data['proCategory'],
                  prodescription: data['proDesc'],
                  proid: data['_id'],
                ))
            .toList();

        return product;
      }
    } catch (e) {
      // print(e);
    }
  }
}

class GetAddedProductDataCategoryWiseData {
  final String proname;
  final int proprice;
  final String proqty;
  final String procategory;
  final String prodescription;
  final String proid;

  GetAddedProductDataCategoryWiseData({
    required this.proname,
    required this.proprice,
    required this.proqty,
    required this.procategory,
    required this.prodescription,
    required this.proid,
  });
}
