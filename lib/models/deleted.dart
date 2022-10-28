// To parse required this JSON data, do
//
//     final deleted = deletedFromMap(jsonString);

import 'dart:convert';

class Deleted {
  Deleted({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<dynamic> data;
  String message;

  factory Deleted.fromJson(String str) => Deleted.fromMap(json.decode(str));

  factory Deleted.fromMap(Map<String, dynamic> json) => Deleted(
        success: json["success"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        message: json["message"],
      );
}
