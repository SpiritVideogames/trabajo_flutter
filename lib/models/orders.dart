// To parse required this JSON data, do
//
//     final orders = ordersFromMap(jsonString);

import 'dart:convert';

class Orders {
  Orders({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<Datum> data;
  String message;

  factory Orders.fromJson(String str) => Orders.fromMap(json.decode(str));

  factory Orders.fromMap(Map<String, dynamic> json) => Orders(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        message: json["message"],
      );
}

class Datum {
  Datum({
    required this.id,
    required this.num,
    required this.issueDate,
    required this.targetCompanyName,
    required this.createdAt,
    required this.deliveryNotes,
    required this.invoices,
  });

  int id;
  String num;
  String issueDate;
  String targetCompanyName;
  String createdAt;
  int deliveryNotes;
  int invoices;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        num: json["num"],
        issueDate: json["issue_date"],
        targetCompanyName: json["target_company_name"],
        createdAt: json["created_at"],
        deliveryNotes: json["delivery_notes"],
        invoices: json["invoices"],
      );
}
