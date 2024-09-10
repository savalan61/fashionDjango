import 'dart:convert';

class SigInModel {
  final String username;
  final String password;

  SigInModel({
    required this.username,
    required this.password,
  });

  factory SigInModel.fromJson(Map<String, dynamic> json) => SigInModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}

SigInModel signInModelFromJson(String str) => SigInModel.fromJson(json.decode(str));

String signInModelToJson(SigInModel data) => json.encode(data.toJson());
