import 'package:fashion_django/common/utils/environment.dart';
import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  ProductRepository(this.client);

  final http.Client client;

  Future<List<ProductModel>> fetchAllProducts() async {
    final Uri url = Uri.parse('${Environment.appBaseUrl}/api/products/');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final products = productModelFromJson(res.body);
      return products;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<List<ProductModel>> fetchProductsByClothesType(String clothesType) async {
    final Uri url = Uri.parse('${Environment.appBaseUrl}/api/products-by-clothes-type/?clothesType=$clothesType');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final products = productModelFromJson(res.body);
      return products;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
