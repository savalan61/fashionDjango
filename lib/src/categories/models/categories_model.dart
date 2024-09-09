import 'dart:convert';

class CategoryModel {
  final int id;
  final String title;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
      };
}

List<CategoryModel> categoriesFromJson(String str) =>
    List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoriesToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
