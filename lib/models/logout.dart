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
  DataLogout data;
  String message;

  factory Logout.fromJson(String str) => Logout.fromMap(json.decode(str));

  factory Logout.fromMap(Map<String, dynamic> json) => Logout(
        success: json["success"],
        data: DataLogout.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataLogout {
  DataLogout({
    required this.id,
  });

  int id;

  factory DataLogout.fromJson(String str) =>
      DataLogout.fromMap(json.decode(str));

  factory DataLogout.fromMap(Map<String, dynamic> json) => DataLogout(
        id: json["id"],
      );
}
