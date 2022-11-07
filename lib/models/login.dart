// To parse required this JSON data, do
//
//     final login = loginFromMap(jsonString);

import 'dart:convert';

class Login {
  Login({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data5 data;
  String message;

  factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        success: json["success"],
        data: Data5.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data5 {
  Data5({
    required this.token,
    required this.id,
    required this.numOfferApplied,
    required this.type,
  });

  String token;
  int id;
  int numOfferApplied;
  String type;

  factory Data5.fromJson(String str) => Data5.fromMap(json.decode(str));

  factory Data5.fromMap(Map<String, dynamic> json) => Data5(
        token: json["token"],
        id: json["id"],
        numOfferApplied: json["num_offer_applied"],
        type: json["type"],
      );
}
