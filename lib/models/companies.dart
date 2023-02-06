// To parse required this JSON data, do
//
//     final companies = companiesFromMap(jsonString);

import 'dart:convert';

class Companies {
  Companies({
    required this.success,
    required this.data,
    required this.message,
  });
  bool success;
  List<DataCompanies> data;
  String message;

  factory Companies.fromJson(String str) => Companies.fromMap(json.decode(str));

  factory Companies.fromMap(Map<String, dynamic> json) => Companies(
        success: json["success"],
        data: List<DataCompanies>.from(
            json["data"].map((x) => DataCompanies.fromMap(x))),
        message: json["message"],
      );
}

class DataCompanies {
  DataCompanies({
    this.id,
    this.name,
    this.address,
    this.city,
    this.cif,
    this.email,
    this.phone,
    this.delTermId,
    this.transportId,
    this.paymentTermId,
    this.discountId,
  });

  int? id;
  String? name;
  String? address;
  String? city;
  String? cif;
  String? email;
  String? phone;
  String? delTermId;
  int? transportId;
  String? paymentTermId;
  String? discountId;

  factory DataCompanies.fromJson(String str) =>
      DataCompanies.fromMap(json.decode(str));

  factory DataCompanies.fromMap(Map<String, dynamic> json) => DataCompanies(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        cif: json["cif"],
        email: json["email"],
        phone: json["phone"],
        delTermId: json["del_term_id"],
        transportId: json["transport_id"],
        paymentTermId: json["payment_term_id"],
        discountId: json["discount_id"],
      );
}
