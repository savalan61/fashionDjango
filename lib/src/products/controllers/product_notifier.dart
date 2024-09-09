import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductNotifier extends ChangeNotifier {
  ProductModel? product;

  void setProduct(ProductModel p) {
    product = p;
    notifyListeners();
  }
}
