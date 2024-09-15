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

  Future<List<ProductModel>> fetchProductsByCat(int id) async {
    final url = '${Environment.appBaseUrl}/api/filter-products-by-category/?category=$id';
    final res = await client.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return productModelFromJson(res.body);
    } else {
      throw Exception('Failed to load top categories');
    }
  }

  Future<List<ProductModel>> fetchSimilarProducts(int catId) async {
    final url = '${Environment.appBaseUrl}/api/similar-products/?category=$catId';
    final res = await client.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final List<ProductModel> products = productModelFromJson(res.body);
      return products;
    } else {
      print('Failed to load similar products. Status code: ${res.statusCode}');
      throw Exception('Failed to load similar products');
    }
  }
}
