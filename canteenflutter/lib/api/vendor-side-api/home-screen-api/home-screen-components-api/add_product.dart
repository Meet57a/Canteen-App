import 'dart:convert';
import 'dart:typed_data';
import 'package:canteenflutter/config/config.dart';
import 'package:http/http.dart' as http;

class AddProductApiVendor {
  static Future<Map<String, dynamic>> addProduct(
    Uint8List? image,
    String mimeType,
    String userId,
    String proName,
    String proPrice,
    String proDesc,
    String proCategory,
    String proQuantity,
    
  ) async {
    var regBody = {
      // "Id" :
      "userId": userId,
      "proName": proName,
      "proPrice": proPrice,
      "proDesc": proDesc,
      "proCategory": proCategory,
      "proQuantity": proQuantity,
      "image": image,
      "mimeType": mimeType,
      
    };
    // print(proDesc);
    final response = await http.post(
      Uri.parse(addproduct),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(regBody),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to upload data');
    }
  }
}
