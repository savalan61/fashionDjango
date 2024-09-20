import 'dart:convert';

class CartCountModel {
  CartCountModel({
    required this.cartItemsCount,
  });

  factory CartCountModel.fromJson(Map<String, dynamic> json) => CartCountModel(
        cartItemsCount: json["cart_items_count"],
      );
  final int cartItemsCount;

  Map<String, dynamic> toJson() => {
        "cart_items_count": cartItemsCount,
      };
}

CartCountModel cartCountModelFromJson(String str) => CartCountModel.fromJson(json.decode(str));

String cartCountModelToJson(CartCountModel data) => json.encode(data.toJson());
