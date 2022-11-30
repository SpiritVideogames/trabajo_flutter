// To parse required this JSON data, do
//
//     final productsCompany = productsCompanyFromMap(jsonString);

import 'dart:convert';

class ProductsCompany {
  ProductsCompany({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<DataProductsCompany> data;
  String message;

  factory ProductsCompany.fromJson(String str) =>
      ProductsCompany.fromMap(json.decode(str));

  factory ProductsCompany.fromMap(Map<String, dynamic> json) => ProductsCompany(
        success: json["success"],
        data: List<DataProductsCompany>.from(
            json["data"].map((x) => DataProductsCompany.fromMap(x))),
        message: json["message"],
      );
}

class DataProductsCompany {
  DataProductsCompany({
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

  factory DataProductsCompany.fromJson(String str) =>
      DataProductsCompany.fromMap(json.decode(str));

  factory DataProductsCompany.fromMap(Map<String, dynamic> json) =>
      DataProductsCompany(
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
