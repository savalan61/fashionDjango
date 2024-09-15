import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishListNotifier extends StateNotifier<List<ProductModel>> {
  WishListNotifier() : super([]);

  void addToList(ProductModel p) => state = [...state, p];

  void removeFromList(ProductModel p) => state = state.where((item) => item.id != p.id).toList();

  bool isInList(ProductModel p) => state.any((element) => element.id == p.id);
}

final wishListProvider = StateNotifierProvider<WishListNotifier, List<ProductModel>>((ref) => WishListNotifier());
