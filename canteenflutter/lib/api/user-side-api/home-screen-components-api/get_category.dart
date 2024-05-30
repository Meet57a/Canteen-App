import 'dart:convert';
import 'package:canteenflutter/config/config.dart';
import 'package:http/http.dart' as http;

class GetCategory {
  static List<CategoryList> category = [];
  static getCategory() async {
    try {
      final res = await http.post(Uri.parse(getCategoryList));

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body);
        category = jsonData
            .map((data) => CategoryList(
                  categoryName: data['categoryName'],
                  catid: data['_id'], 
                ))
            .toList();
        return category;
      }
    } catch (e) {
      rethrow;
    }
  }
}

class CategoryList {
  String categoryName = "";
  String catid = "";
  CategoryList({
    required this.categoryName,
    required this.catid,
  });
}
