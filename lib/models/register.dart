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
  Data7 data;
  String message;

  factory Register.fromJson(String str) => Register.fromMap(json.decode(str));

  factory Register.fromMap(Map<String, dynamic> json) => Register(
        success: json["success"],
        data: Data7.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data7 {
  Data7({
    required this.token,
    required this.name,
  });

  String token;
  String name;

  factory Data7.fromJson(String str) => Data7.fromMap(json.decode(str));

  factory Data7.fromMap(Map<String, dynamic> json) => Data7(
        token: json["token"],
        name: json["name"],
      );
}
