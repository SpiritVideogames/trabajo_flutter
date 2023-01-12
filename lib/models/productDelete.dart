// To parse required this JSON data, do
//
//     final productDelete = productDeleteFromMap(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

class ProductDelete {
  ProductDelete({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<dynamic> data;
  String message;

  factory ProductDelete.fromJson(String str) =>
      ProductDelete.fromMap(json.decode(str));

  factory ProductDelete.fromMap(Map<String, dynamic> json) => ProductDelete(
        success: json["success"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        message: json["message"],
      );
}
