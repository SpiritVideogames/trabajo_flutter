// To parse required this JSON data, do
//
//     final deactivate = deactivateFromMap(jsonString);

import 'dart:convert';

class Deactivate {
  Deactivate({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data4 data;
  String message;

  factory Deactivate.fromJson(String str) =>
      Deactivate.fromMap(json.decode(str));

  factory Deactivate.fromMap(Map<String, dynamic> json) => Deactivate(
        success: json["success"],
        data: Data4.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data4 {
  Data4({
    required this.id,
  });

  int id;

  factory Data4.fromJson(String str) => Data4.fromMap(json.decode(str));

  factory Data4.fromMap(Map<String, dynamic> json) => Data4(
        id: json["id"],
      );
}
