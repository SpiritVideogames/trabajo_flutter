// To parse required this JSON dataProductAdd, do
//
//     final productAdd = productAddFromMap(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

class ProductAdd {
  ProductAdd({
    required this.success,
    required this.dataProductAdd,
    required this.message,
  });

  bool success;
  DataProductAdd dataProductAdd;
  String message;

  factory ProductAdd.fromJson(String str) =>
      ProductAdd.fromMap(json.decode(str));

  factory ProductAdd.fromMap(Map<String, dynamic> json) => ProductAdd(
        success: json["success"],
        dataProductAdd: DataProductAdd.fromMap(json["dataProductAdd"]),
        message: json["message"],
      );
}

class DataProductAdd {
  DataProductAdd({
    required this.id,
    required this.articleId,
    required this.companyId,
    required this.compamyName,
    required this.compamyDescription,
    required this.price,
    required this.stock,
    required this.familyId,
    required this.deleted,
  });

  int id;
  String articleId;
  String companyId;
  String compamyName;
  String compamyDescription;
  String price;
  dynamic stock;
  String familyId;
  dynamic deleted;

  factory DataProductAdd.fromJson(String str) =>
      DataProductAdd.fromMap(json.decode(str));

  factory DataProductAdd.fromMap(Map<String, dynamic> json) => DataProductAdd(
        id: json["id"],
        articleId: json["article_id"],
        companyId: json["company_id"],
        compamyName: json["compamy_name"],
        compamyDescription: json["compamy_description"],
        price: json["price"],
        stock: json["stock"],
        familyId: json["family_id"],
        deleted: json["deleted"],
      );
}
