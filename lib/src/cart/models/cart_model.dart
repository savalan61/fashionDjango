import 'dart:convert';

class CartModel {
  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.size,
    required this.color,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        size: json["size"],
        color: json["color"],
      );

  final int id;
  final Product product;
  final int quantity;
  final String size;
  final String color;

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "quantity": quantity,
        "size": size,
        "color": color,
      };
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.clothesType,
    required this.rating,
    required this.colors,
    required this.sizes,
    required this.imageUrls,
    required this.createdAt,
    required this.category,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        isFeatured: json["isFeatured"],
        clothesType: json["clothesType"],
        rating: json["rating"],
        colors: List<String>.from(json["colors"].map((x) => x)),
        sizes: List<String>.from(json["sizes"].map((x) => x)),
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        category: json["category"],
        brand: json["brand"],
      );

  final int id;
  final String title;
  final double price;
  final String description;
  final bool isFeatured;
  final String clothesType;
  final double rating;
  final List<String> colors;
  final List<String> sizes;
  final List<String> imageUrls;
  final DateTime createdAt;
  final int category;
  final int brand;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "isFeatured": isFeatured,
        "clothesType": clothesType,
        "rating": rating,
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "category": category,
        "brand": brand,
      };
}

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
