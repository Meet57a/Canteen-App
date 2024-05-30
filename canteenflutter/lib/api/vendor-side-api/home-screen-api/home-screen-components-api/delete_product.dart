import 'package:canteenflutter/config/config.dart';
import 'package:http/http.dart' as http;

class DeleteProductApiVendor {
  static deleteProduct(id) async {
    // print(id);
    final res = await http.post(Uri.parse("${url}deleteProduct/$id"));
    if (res.statusCode == 200) {
    } else {
      throw Exception('Failed to delete data');
    }
  }
}
