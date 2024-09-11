import 'dart:convert';

class ProfileModel {
  final int id;
  final String username;
  final String email;

  ProfileModel({
    required this.id,
    required this.username,
    required this.email,
  });

  // Named constructor to create an empty ProfileModel
  factory ProfileModel.empty() => ProfileModel(
        id: 0,
        username: '',
        email: '',
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
      };
}

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());
