import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/wishList_product.dart';
import '../repository/wishList_repository.dart';

class WishListNotifier extends StateNotifier<AsyncValue<List<WishListProduct>>> {
  WishListNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadWishList();
  }

  final WishListRepository _repository;

  Future<void> _loadWishList() async {
    state = const AsyncValue.loading();
    try {
      final wishList = await _repository.fetchWishList();
      final wishListProducts = wishList.map((product) {
        return WishListProduct(product: product, isWished: true);
      }).toList();
      state = AsyncValue.data(wishListProducts);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> toggleWishList(String productId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.toggleWishList(productId);
      _loadWishList(); // Refresh wishlist
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
