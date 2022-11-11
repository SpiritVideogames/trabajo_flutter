// To parse required this JSON data, do
//
//     final applied = appliedFromMap(jsonString);

import 'dart:convert';

class Applied {
  Applied({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  DataApplied data;
  String message;

  factory Applied.fromJson(String str) => Applied.fromMap(json.decode(str));

  factory Applied.fromMap(Map<String, dynamic> json) => Applied(
        success: json["success"],
        data: DataApplied.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataApplied {
  DataApplied({
    required this.offerId,
  });

  String offerId;

  factory DataApplied.fromJson(String str) =>
      DataApplied.fromMap(json.decode(str));

  factory DataApplied.fromMap(Map<String, dynamic> json) => DataApplied(
        offerId: json["offer_id"],
      );
}
