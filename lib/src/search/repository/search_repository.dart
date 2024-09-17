import 'package:fashion_django/common/utils/environment.dart';
import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:http/http.dart' as http;

class SearchRepository {
  // SearchRepository(this.client);
  // final http.Client client;

  Future<List<ProductModel>> searchResult(String search) async {
    final Uri uri = Uri.parse('${Environment.appBaseUrl}/api/search-products/?q=$search');
    final http.Response res = await http.get(uri);
    if (res.statusCode == 200) {
      return productModelFromJson(res.body);
    } else {
      // throw "Something went wrong";
      return [];
    }
  }
}
