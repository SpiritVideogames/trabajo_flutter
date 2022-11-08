// To parse required this JSON data, do
//
//     final register = registerFromMap(jsonString);

import 'dart:convert';

class Register {
  Register({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data8 data;
  String message;

  factory Register.fromJson(String str) => Register.fromMap(json.decode(str));

  factory Register.fromMap(Map<String, dynamic> json) => Register(
        success: json["success"],
        data: Data8.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data8 {
  Data8({
    required this.token,
    required this.name,
  });

  String token;
  String name;

  factory Data8.fromJson(String str) => Data8.fromMap(json.decode(str));

  factory Data8.fromMap(Map<String, dynamic> json) => Data8(
        token: json["token"],
        name: json["name"],
      );
}
