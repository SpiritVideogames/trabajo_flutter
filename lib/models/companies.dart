// To parse required this JSON datum, do
//
//     final companies = companiesFromMap(jsonString);

import 'dart:convert';

class Companies {
  Companies({
    required this.success,
    required this.datum,
    required this.message,
  });

  bool success;
  List<Datum> datum;
  String message;

  factory Companies.fromJson(String str) => Companies.fromMap(json.decode(str));

  factory Companies.fromMap(Map<String, dynamic> json) => Companies(
        success: json["success"],
        datum: List<Datum>.from(json["datum"].map((x) => Datum.fromMap(x))),
        message: json["message"],
      );
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.cif,
    required this.email,
    required this.phone,
    required this.delTermId,
    required this.transportId,
    required this.paymentTermId,
    required this.discountId,
  });

  int id;
  String name;
  String address;
  String city;
  String cif;
  String email;
  String phone;
  String delTermId;
  int transportId;
  String paymentTermId;
  String discountId;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
