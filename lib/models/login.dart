// To parse this JSON data3, do
//
//     final login = loginFromMap(jsonString);

import 'dart:convert';

class Login {
  Login({
    required this.success,
    required this.data3,
    required this.message,
  });

  bool success;
  Data3 data3;
  String message;

  factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        success: json["success"],
        data3: Data3.fromMap(json["data3"]),
        message: json["message"],
      );
}

class Data3 {
  Data3({
    required this.token,
    required this.id,
    required this.type,
    required this.actived,
  });

  String token;
  int id;
  String type;
  int actived;

  factory Data3.fromJson(String str) => Data3.fromMap(json.decode(str));

  factory Data3.fromMap(Map<String, dynamic> json) => Data3(
        token: json["token"],
        id: json["id"],
        type: json["type"],
        actived: json["actived"],
      );
}
