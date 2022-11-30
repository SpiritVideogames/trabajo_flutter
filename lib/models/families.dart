// To parse required this JSON data, do
//
//     final families = familiesFromMap(jsonString);

import 'dart:convert';

class Families {
  Families({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<DataFamilies> data;
  String message;

  factory Families.fromJson(String str) => Families.fromMap(json.decode(str));

  factory Families.fromMap(Map<String, dynamic> json) => Families(
        success: json["success"],
        data: List<DataFamilies>.from(
            json["data"].map((x) => DataFamilies.fromMap(x))),
        message: json["message"],
      );
}

class DataFamilies {
  DataFamilies({
    required this.id,
    required this.name,
    required this.profitMargin,
    required this.deleted,
  });

  int id;
  String name;
  String profitMargin;
  int deleted;

  factory DataFamilies.fromJson(String str) =>
      DataFamilies.fromMap(json.decode(str));

  factory DataFamilies.fromMap(Map<String, dynamic> json) => DataFamilies(
        id: json["id"],
        name: json["name"],
        profitMargin: json["profit_margin"],
        deleted: json["deleted"],
      );
}
