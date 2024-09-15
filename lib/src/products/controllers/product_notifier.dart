import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductNotifier extends ChangeNotifier {
  // Product
  ProductModel? product;
  void setProduct(ProductModel p) {
    product = p;
    notifyListeners();
  }

  // Sizes
  String _size = "";
  String get size => _size;
  void setSizes(String s) {
    _size == s ? _size = "" : _size = s;
    notifyListeners();
  }

  // Colors
  String _color = "";
  String get color => _color;
  void setColor(String c) {
    _color == c ? _color = "" : _color = c;
    notifyListeners();
  }
}
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fashion_django/src/products/models/product_model.dart';
//
// import '../models/product_state.dart';
//
// class ProductNotifier extends StateNotifier<ProductState> {
//   ProductNotifier() : super(ProductState());
//
//   // Set Product
//   void setProduct(ProductModel p) {
//     state = state.copyWith(product: p);
//   }
//
//   // Set Size
//   void setSizes(String s) {
//     state = state.copyWith(size: state.size == s ? "" : s);
//   }
//
//   // Set Color
//   void setColor(String c) {
//     state = state.copyWith(color: state.color == c ? "" : c);
//   }
// }
//
//
//
// // Provider for ProductNotifier
// final productNotifierProvider =
// StateNotifierProvider<ProductNotifier, ProductState>((ref) {
//   return ProductNotifier();
// });
