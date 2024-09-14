import 'dart:convert';

class ProductModel {
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        isFeatured: json['isFeatured'],
        clothesType: json['clothesType'],
        rating: json['rating']?.toDouble(),
        colors: List<String>.from(json['colors'].map((x) => x)),
        imageUrls: List<String>.from(json['imageUrls'].map((x) => x)),
        sizes: List<String>.from(json['sizes'].map((x) => x)),
        createdAt: DateTime.parse(json['created_at']),
        category: json['category'],
        brand: json['brand'],
      );

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.clothesType,
    required this.rating,
    required this.colors,
    required this.imageUrls,
    required this.sizes,
    required this.createdAt,
    required this.category,
    required this.brand,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final bool isFeatured; // تغییر به isFeatured
  final String clothesType;
  final double rating; // تغییر به rating
  final List<String> colors;
  final List<String> imageUrls;
  final List<String> sizes;
  final DateTime createdAt;
  final int category;
  final int brand;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'isFeatured': isFeatured,
        'clothesType': clothesType,
        'rating': rating,
        'colors': List<dynamic>.from(colors.map((x) => x)),
        'imageUrls': List<dynamic>.from(imageUrls.map((x) => x)),
        'sizes': List<dynamic>.from(sizes.map((x) => x)),
        'created_at': createdAt.toIso8601String(),
        'category': category,
        'brand': brand,
      };
}

List<ProductModel> productModelFromJson(String str) =>
    List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
