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
  List<DataOrders> data;
  String message;

  factory Orders.fromJson(String str) => Orders.fromMap(json.decode(str));

  factory Orders.fromMap(Map<String, dynamic> json) => Orders(
        success: json["success"],
        data: List<DataOrders>.from(
            json["data"].map((x) => DataOrders.fromMap(x))),
        message: json["message"],
      );
}

class DataOrders {
  DataOrders({
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

  factory DataOrders.fromJson(String str) =>
      DataOrders.fromMap(json.decode(str));

  factory DataOrders.fromMap(Map<String, dynamic> json) => DataOrders(
        id: json["id"],
        num: json["num"],
        issueDate: json["issue_date"],
        targetCompanyName: json["target_company_name"],
        createdAt: json["created_at"],
        deliveryNotes: json["delivery_notes"],
        invoices: json["invoices"],
      );
}
