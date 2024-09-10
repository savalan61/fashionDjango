import 'dart:convert';

class SignUpModel {
  final String email;
  final String username;
  final String password;

  SignUpModel({
    required this.email,
    required this.username,
    required this.password,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        email: json["email"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "password": password,
      };
}

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());
