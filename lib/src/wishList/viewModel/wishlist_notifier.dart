import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/models/product_model.dart';
import '../repository/wishList_repository.dart';

class WishListNotifier extends StateNotifier<AsyncValue<List<WishListProduct>>> {
  WishListNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadWishList();
  }

  final WishListRepository _repository;

  // Load the wish list from the repository
  Future<void> _loadWishList() async {
    try {
      final wishList = await _repository.fetchWishList();
      // Map to WishListProduct
      final wishListProducts = wishList.map((product) {
        return WishListProduct(
          product: product,
          isWished: true, // Assuming you receive information if the product is wished
        );
      }).toList();
      state = AsyncValue.data(wishListProducts);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // Toggle the wish list status for a product
  Future<void> toggleWishList(String productId) async {
    state = const AsyncValue.loading();
    try {
      final message = await _repository.toggleWishList(productId);
      // Refresh the wish list after toggling
      _loadWishList();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

// Provider for managing wish list state with StateNotifier
final wishListNotifierProvider = StateNotifierProvider<WishListNotifier, AsyncValue<List<WishListProduct>>>((ref) {
  final repository = WishListRepository(); // Adjust base URL
  return WishListNotifier(repository);
});

// wish_list_product_model.dart

class WishListProduct {
  WishListProduct({
    required this.product,
    required this.isWished,
  });

  factory WishListProduct.fromJson(Map<String, dynamic> json) {
    return WishListProduct(
      product: ProductModel.fromJson(json['product']),
      isWished: json['is_wished'] ?? false, // Adjust based on API response
    );
  }

  final ProductModel product;
  final bool isWished;
}
