// To parse required this JSON data, do
//
//     final unapplied = unappliedFromMap(jsonString);

import 'dart:convert';

class Unapplied {
  Unapplied({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  DataUnapplied data;
  String message;

  factory Unapplied.fromJson(String str) => Unapplied.fromMap(json.decode(str));

  factory Unapplied.fromMap(Map<String, dynamic> json) => Unapplied(
        success: json["success"],
        data: DataUnapplied.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataUnapplied {
  DataUnapplied({
    required this.offerId,
  });

  String offerId;

  factory DataUnapplied.fromJson(String str) =>
      DataUnapplied.fromMap(json.decode(str));

  factory DataUnapplied.fromMap(Map<String, dynamic> json) => DataUnapplied(
        offerId: json["offer_id"],
      );
}
