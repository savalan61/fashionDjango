import 'package:fashion_django/src/products/models/product_model.dart';

class ProductState {
  ProductState({this.product, this.size = "", this.color = ""});

  final ProductModel? product;
  final String size;
  final String color;

  ProductState copyWith({
    ProductModel? product,
    String? size,
    String? color,
  }) {
    return ProductState(
      product: product ?? this.product,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }
}
