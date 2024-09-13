import 'package:http/http.dart' as http;

import '../../../common/utils/environment.dart';
import '../models/categories_model.dart';

class CategoryRepository {
  final http.Client client;

  CategoryRepository(this.client);

  Future<List<CategoryModel>> fetchAllCategories() async {
    var url = "${Environment.appBaseUrl}/api/categories/";
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return categoriesFromJson(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<CategoryModel>> fetchTopCategories() async {
    var url = "${Environment.appBaseUrl}/api/home-categories/";
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return categoriesFromJson(response.body);
    } else {
      throw Exception('Failed to load top categories');
    }
  }
}
