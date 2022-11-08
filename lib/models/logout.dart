// To parse required this JSON data, do
//
//     final logout = logoutFromMap(jsonString);

import 'dart:convert';

class Logout {
  Logout({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data7 data;
  String message;

  factory Logout.fromJson(String str) => Logout.fromMap(json.decode(str));

  factory Logout.fromMap(Map<String, dynamic> json) => Logout(
        success: json["success"],
        data: Data7.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data7 {
  Data7({
    required this.id,
  });

  int id;

  factory Data7.fromJson(String str) => Data7.fromMap(json.decode(str));

  factory Data7.fromMap(Map<String, dynamic> json) => Data7(
        id: json["id"],
      );
}
