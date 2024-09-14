import 'dart:convert';

ApiError apiErrorFromJson(String str) => ApiError.fromJson(json.decode(str));

class ApiError {
  ApiError({
    required this.message,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        message: json['message'],
      );
  final String message;
}
