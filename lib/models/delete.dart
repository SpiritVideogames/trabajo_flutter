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
  DataDelete data;
  String message;

  factory Delete.fromJson(String str) => Delete.fromMap(json.decode(str));

  factory Delete.fromMap(Map<String, dynamic> json) => Delete(
        success: json["success"],
        data: DataDelete.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataDelete {
  DataDelete();

  factory DataDelete.fromJson(String str) =>
      DataDelete.fromMap(json.decode(str));

  factory DataDelete.fromMap(Map<String, dynamic> json) => DataDelete();
}
