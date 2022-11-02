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
  Data5 data;
  String message;

  factory Register.fromJson(String str) => Register.fromMap(json.decode(str));

  factory Register.fromMap(Map<String, dynamic> json) => Register(
        success: json["success"],
        data: Data5.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data5 {
  Data5({
    required this.token,
    required this.name,
  });

  String token;
  String name;

  factory Data5.fromJson(String str) => Data5.fromMap(json.decode(str));

  factory Data5.fromMap(Map<String, dynamic> json) => Data5(
        token: json["token"],
        name: json["name"],
      );
}
