import 'dart:convert';
import 'package:fashion_django/common/services/storage.dart';
import 'package:fashion_django/src/cart/models/cart_count_model.dart';
import 'package:fashion_django/src/cart/models/cart_create_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../common/utils/environment.dart';
import '../models/cart_model.dart';

// CartRepository Class
class CartRepository {
  CartRepository(this.client);

  final http.Client client;

  // Helper method to get the access token
  Future<String?> _getAccessToken() async {
    return Storage().getString("accessToken");
  }

  // Helper method to create headers
  Future<Map<String, String>> _createHeaders() async {
    final accessToken = await _getAccessToken();
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      if (accessToken != null) 'Authorization': 'Token $accessToken',
    };
  }

  // Add an item to the cart
  Future<void> addToCart(CartCreateModel cartCreateModel) async {
    final url = '${Environment.appBaseUrl}/api/cart/add/';
    final response = await client.post(
      Uri.parse(url),
      headers: await _createHeaders(),
      body: cartCreateModelToJson(cartCreateModel),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to add item to cart');
    }
  }

  // Remove an item from the cart
  Future<void> removeFromCart(int cartItemId) async {
    final url = '${Environment.appBaseUrl}/api/cart/remove/$cartItemId/';
    final response = await client.delete(
      Uri.parse(url),
      headers: await _createHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove item from cart');
    }
  }

  // Get the count of items in the cart
  Future<CartCountModel> getCartCount() async {
    final url = '${Environment.appBaseUrl}/api/cart/count/';
    final response = await client.get(
      Uri.parse(url),
      headers: await _createHeaders(),
    );

    if (response.statusCode == 200) {
      return cartCountModelFromJson(response.body);
    } else {
      throw Exception('Failed to load cart count');
    }
  }

  // Update the quantity of an item in the cart
  Future<void> updateCartItemQuantity(int itemId, int count) async {
    final url = '${Environment.appBaseUrl}/api/cart/update-quantity/?id=$itemId&count=$count';
    print("itemId:$itemId  --------  count : $count");
    final response = await client.patch(
      Uri.parse(url),
      headers: await _createHeaders(),
      body: jsonEncode({
        'id': itemId,
        'count': count,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update item quantity');
    }
  }

  // Get the user's cart
  Future<List<CartModel>> getUserCart() async {
    final url = '${Environment.appBaseUrl}/api/cart/user/';
    final response = await client.get(
      Uri.parse(url),
      headers: await _createHeaders(),
    );

    if (response.statusCode == 200) {
      var s = response.body;
      final List<CartModel> carts = cartModelFromJson(s);
      return carts;
    } else {
      throw Exception('Failed to load user cart');
    }
  }
}
