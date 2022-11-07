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
  Data6 data;
  String message;

  factory Logout.fromJson(String str) => Logout.fromMap(json.decode(str));

  factory Logout.fromMap(Map<String, dynamic> json) => Logout(
        success: json["success"],
        data: Data6.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data6 {
  Data6({
    required this.id,
  });

  int id;

  factory Data6.fromJson(String str) => Data6.fromMap(json.decode(str));

  factory Data6.fromMap(Map<String, dynamic> json) => Data6(
        id: json["id"],
      );
}
