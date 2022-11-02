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
  Data2 data;
  String message;

  factory Applied.fromJson(String str) => Applied.fromMap(json.decode(str));

  factory Applied.fromMap(Map<String, dynamic> json) => Applied(
        success: json["success"],
        data: Data2.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data2 {
  Data2({
    required this.offerId,
  });

  String offerId;

  factory Data2.fromJson(String str) => Data2.fromMap(json.decode(str));

  factory Data2.fromMap(Map<String, dynamic> json) => Data2(
        offerId: json["offer_id"],
      );
}
