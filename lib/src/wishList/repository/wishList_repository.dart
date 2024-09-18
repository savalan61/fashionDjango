import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../common/services/storage.dart';
import '../../../common/utils/environment.dart';
import '../../products/models/product_model.dart';

class WishListRepository {
  // Fetch the wish list for the current user
  Future<List<ProductModel>> fetchWishList() async {
    final String? accessToken = Storage().getString("accessToken");
    final url = Uri.parse('${Environment.appBaseUrl}/api/favoriteList/me/');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $accessToken', 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load wish list');
    }
  }

  // Add or remove a product from the wish list
  Future<String> toggleWishList(String productId) async {
    final String? accessToken = Storage().getString("accessToken");
    final url = Uri.parse('${Environment.appBaseUrl}/api/favoriteList/toggle/?id=$productId');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $accessToken', 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return 'Product added to wish list';
    } else if (response.statusCode == 204) {
      return 'Product removed from wish list';
    } else {
      throw Exception('Failed to toggle wish list');
    }
  }
}
