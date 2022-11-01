// To parse this JSON data2, do
//
//     final deactivate = deactivateFromMap(jsonString);

import 'dart:convert';

class Deactivate {
  Deactivate({
    required this.success,
    required this.data2,
    required this.message,
  });

  bool success;
  Data2 data2;
  String message;

  factory Deactivate.fromJson(String str) =>
      Deactivate.fromMap(json.decode(str));

  factory Deactivate.fromMap(Map<String, dynamic> json) => Deactivate(
        success: json["success"],
        data2: Data2.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data2 {
  Data2({
    required this.id,
  });

  int id;

  factory Data2.fromJson(String str) => Data2.fromMap(json.decode(str));

  factory Data2.fromMap(Map<String, dynamic> json) => Data2(
        id: json["id"],
      );
}
