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
  Data6 data;
  String message;

  factory Unapplied.fromJson(String str) => Unapplied.fromMap(json.decode(str));

  factory Unapplied.fromMap(Map<String, dynamic> json) => Unapplied(
        success: json["success"],
        data: Data6.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data6 {
  Data6({
    required this.offerId,
  });

  String offerId;

  factory Data6.fromJson(String str) => Data6.fromMap(json.decode(str));

  factory Data6.fromMap(Map<String, dynamic> json) => Data6(
        offerId: json["offer_id"],
      );
}
