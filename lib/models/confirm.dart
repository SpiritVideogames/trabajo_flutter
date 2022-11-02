// To parse required this JSON data, do
//
//     final confirm = confirmFromMap(jsonString);

import 'dart:convert';

class Confirm {
  Confirm({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data3 data;
  String message;

  factory Confirm.fromJson(String str) => Confirm.fromMap(json.decode(str));

  factory Confirm.fromMap(Map<String, dynamic> json) => Confirm(
        success: json["success"],
        data: Data3.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data3 {
  Data3({
    required this.id,
  });

  int id;

  factory Data3.fromJson(String str) => Data3.fromMap(json.decode(str));

  factory Data3.fromMap(Map<String, dynamic> json) => Data3(
        id: json["id"],
      );
}
