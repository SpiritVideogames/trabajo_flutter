// To parse required this JSON dataArticle, do
//
//     final article = articleFromMap(jsonString);

import 'dart:convert';

class Article {
  Article({
    required this.success,
    required this.dataArticle,
    required this.message,
  });

  bool success;
  DataArticle dataArticle;
  String message;

  factory Article.fromJson(String str) => Article.fromMap(json.decode(str));

  factory Article.fromMap(Map<String, dynamic> json) => Article(
        success: json["success"],
        dataArticle: DataArticle.fromMap(json["dataArticle"]),
        message: json["message"],
      );
}

class DataArticle {
  DataArticle({
    this.id,
    this.name,
    this.description,
    this.priceMin,
    this.priceMax,
    this.colorName,
    this.weight,
    this.size,
    this.familyId,
    this.deleted,
  });

  int? id;
  String? name;
  String? description;
  String? priceMin;
  String? priceMax;
  String? colorName;
  String? weight;
  String? size;
  int? familyId;
  int? deleted;

  factory DataArticle.fromJson(String str) =>
      DataArticle.fromMap(json.decode(str));

  factory DataArticle.fromMap(Map<String, dynamic> json) => DataArticle(
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
