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
  Data8 data;
  String message;

  factory Unapplied.fromJson(String str) => Unapplied.fromMap(json.decode(str));

  factory Unapplied.fromMap(Map<String, dynamic> json) => Unapplied(
        success: json["success"],
        data: Data8.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data8 {
  Data8({
    required this.offerId,
  });

  String offerId;

  factory Data8.fromJson(String str) => Data8.fromMap(json.decode(str));

  factory Data8.fromMap(Map<String, dynamic> json) => Data8(
        offerId: json["offer_id"],
      );
}
