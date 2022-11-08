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
  Data9 data;
  String message;

  factory Unapplied.fromJson(String str) => Unapplied.fromMap(json.decode(str));

  factory Unapplied.fromMap(Map<String, dynamic> json) => Unapplied(
        success: json["success"],
        data: Data9.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data9 {
  Data9({
    required this.offerId,
  });

  String offerId;

  factory Data9.fromJson(String str) => Data9.fromMap(json.decode(str));

  factory Data9.fromMap(Map<String, dynamic> json) => Data9(
        offerId: json["offer_id"],
      );
}
