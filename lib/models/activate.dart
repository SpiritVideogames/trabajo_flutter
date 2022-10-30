// To parse this JSON data, do
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
  Data data;
  String message;

  factory Activate.fromJson(String str) => Activate.fromMap(json.decode(str));

  factory Activate.fromMap(Map<String, dynamic> json) => Activate(
        success: json["success"],
        data: Data.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data {
  Data({
    required this.id,
  });

  int id;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
      );
}
