import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductNotifier1 extends ChangeNotifier {
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
