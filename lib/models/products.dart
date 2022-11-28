// To parse required this JSON data, do
//
//     final products = productsFromMap(jsonString);

import 'dart:convert';

class Products {
  Products({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<DataProducts> data;
  String message;

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        success: json["success"],
        data: List<DataProducts>.from(
            json["data"].map((x) => DataProducts.fromMap(x))),
        message: json["message"],
      );
}

class DataProducts {
  DataProducts({
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
  int articleId;
  int companyId;
  String compamyName;
  String compamyDescription;
  String price;
  int stock;
  int familyId;
  int deleted;

  factory DataProducts.fromJson(String str) =>
      DataProducts.fromMap(json.decode(str));

  factory DataProducts.fromMap(Map<String, dynamic> json) => DataProducts(
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
