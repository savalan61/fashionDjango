import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:fashion_django/src/products/models/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedProdState extends StateNotifier<ProductState> {
  SelectedProdState() : super(ProductState());

  void setProduct(ProductModel p) => state = state.copyWith(product: p);

  void setSize(String s) {
    // state.size == "" ? state = state.copyWith(size: s) : state = state.copyWith(size: "");
    state = state.copyWith(size: s);
  }

  void setColor(String c) {
    // state.color == "" ? state = state.copyWith(color: c) : state = state.copyWith(color: "");
    state = state.copyWith(color: c);
  }
}

final selectedProdNotifier = StateNotifierProvider<SelectedProdState, ProductState>((ref) => SelectedProdState());
