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
  DataConfirm data;
  String message;

  factory Confirm.fromJson(String str) => Confirm.fromMap(json.decode(str));

  factory Confirm.fromMap(Map<String, dynamic> json) => Confirm(
        success: json["success"],
        data: DataConfirm.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataConfirm {
  DataConfirm({
    required this.id,
  });

  int id;

  factory DataConfirm.fromJson(String str) =>
      DataConfirm.fromMap(json.decode(str));

  factory DataConfirm.fromMap(Map<String, dynamic> json) => DataConfirm(
        id: json["id"],
      );
}
