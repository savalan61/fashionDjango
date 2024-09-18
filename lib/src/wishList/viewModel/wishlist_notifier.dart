import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/wishList_product.dart';
import '../repository/wishList_repository.dart';

class WishListNotifier extends StateNotifier<AsyncValue<List<WishListProduct>>> {
  WishListNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadWishList();
  }

  final WishListRepository _repository;

  Future<void> _loadWishList() async {
    try {
      final List<ProductModel> wishList = await _repository.fetchWishList();
      final wishListProducts = wishList.map((product) {
        return WishListProduct(product: product, isWished: true);
      }).toList();
      state = AsyncValue.data(wishListProducts);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> toggleWishList(String productId) async {
    state = state.whenData((wishList) {
      return wishList.map((wishListProduct) {
        if (wishListProduct.product.id == int.parse(productId)) {
          return WishListProduct(
            product: wishListProduct.product,
            isWished: !wishListProduct.isWished,
          );
        }
        return wishListProduct;
      }).toList();
    });

    try {
      await _repository.toggleWishList(productId);
      // Refresh the wishlist after toggling
      _loadWishList();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final wishListNotifierProvider = StateNotifierProvider<WishListNotifier, AsyncValue<List<WishListProduct>>>((ref) {
  final repository = WishListRepository(); // تنظیم URL پایه
  return WishListNotifier(repository);
});
