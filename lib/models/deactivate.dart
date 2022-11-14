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
  DataDeactivate data;
  String message;

  factory Deactivate.fromJson(String str) =>
      Deactivate.fromMap(json.decode(str));

  factory Deactivate.fromMap(Map<String, dynamic> json) => Deactivate(
        success: json["success"],
        data: DataDeactivate.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataDeactivate {
  DataDeactivate({
    required this.id,
  });

  int id;

  factory DataDeactivate.fromJson(String str) =>
      DataDeactivate.fromMap(json.decode(str));

  factory DataDeactivate.fromMap(Map<String, dynamic> json) => DataDeactivate(
        id: json["id"],
      );
}
