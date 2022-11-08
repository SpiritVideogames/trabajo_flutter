// To parse required this JSON data, do
//
//     final delete = deleteFromMap(jsonString);

import 'dart:convert';

class Delete {
  Delete({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data5 data;
  String message;

  factory Delete.fromJson(String str) => Delete.fromMap(json.decode(str));

  factory Delete.fromMap(Map<String, dynamic> json) => Delete(
        success: json["success"],
        data: Data5.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data5 {
  Data5({
    required this.id,
  });

  int id;

  factory Data5.fromJson(String str) => Data5.fromMap(json.decode(str));

  factory Data5.fromMap(Map<String, dynamic> json) => Data5(
        id: json["id"],
      );
}
