// To parse required this JSON data, do
//
//     final activate = activateFromMap(jsonString);

import 'dart:convert';

class Activate {
  Activate({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  DataActivate data;
  String message;

  factory Activate.fromJson(String str) => Activate.fromMap(json.decode(str));

  factory Activate.fromMap(Map<String, dynamic> json) => Activate(
        success: json["success"],
        data: DataActivate.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataActivate {
  DataActivate({
    required this.id,
  });

  int id;

  factory DataActivate.fromJson(String str) =>
      DataActivate.fromMap(json.decode(str));

  factory DataActivate.fromMap(Map<String, dynamic> json) => DataActivate(
        id: json["id"],
      );
}
