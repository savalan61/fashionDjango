import 'dart:convert';

class CartCreateModel {
  CartCreateModel({
    required this.product,
    required this.color,
    required this.size,
    required this.quantity,
  });

  factory CartCreateModel.fromJson(Map<String, dynamic> json) => CartCreateModel(
        product: json["product"],
        color: json["color"],
        size: json["size"],
        quantity: json["quantity"],
      );
  final int product;
  final String color;
  final String size;
  final int quantity;

  Map<String, dynamic> toJson() => {
        "product": product,
        "color": color,
        "size": size,
        "quantity": quantity,
      };
}

CartCreateModel cartCreateModelFromJson(String str) => CartCreateModel.fromJson(json.decode(str));

String cartCreateModelToJson(CartCreateModel data) => json.encode(data.toJson());
