import 'package:canteenflutter/config/config.dart';
import 'package:http/http.dart' as http;

class DeleteOrderedDataApiUser {
  static deleteOrderedDatUser(id) async {
    // print(id);
    final res = await http.post(Uri.parse("${url}deleteOrderedProduct/$id"));
    if (res.statusCode == 200) {
    } else {
      throw Exception('Failed to delete data');
    }
  }
}
