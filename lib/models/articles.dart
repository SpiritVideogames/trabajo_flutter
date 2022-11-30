// To parse required this JSON data, do
//
//     final articles = articlesFromMap(jsonString);

import 'dart:convert';

class Articles {
  Articles({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<DataArticles> data;
  String message;

  factory Articles.fromJson(String str) => Articles.fromMap(json.decode(str));

  factory Articles.fromMap(Map<String, dynamic> json) => Articles(
        success: json["success"],
        data: List<DataArticles>.from(
            json["data"].map((x) => DataArticles.fromMap(x))),
        message: json["message"],
      );
}

class DataArticles {
  DataArticles({
    required this.id,
    required this.name,
    required this.description,
    required this.priceMin,
    required this.priceMax,
    required this.colorName,
    required this.weight,
    required this.size,
    required this.familyId,
    required this.deleted,
  });

  int id;
  String name;
  String description;
  String priceMin;
  String priceMax;
  String colorName;
  String weight;
  String size;
  int familyId;
  int deleted;

  factory DataArticles.fromJson(String str) =>
      DataArticles.fromMap(json.decode(str));

  factory DataArticles.fromMap(Map<String, dynamic> json) => DataArticles(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        priceMin: json["price_min"],
        priceMax: json["price_max"],
        colorName: json["color_name"],
        weight: json["weight"],
        size: json["size"],
        familyId: json["family_id"],
        deleted: json["deleted"],
      );
}
