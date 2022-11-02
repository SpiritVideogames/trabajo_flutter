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
  Data4 data;
  String message;

  factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        success: json["success"],
        data: Data4.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data4 {
  Data4({
    required this.token,
    required this.id,
    required this.numOfferApplied,
    required this.type,
  });

  String token;
  int id;
  int numOfferApplied;
  String type;

  factory Data4.fromJson(String str) => Data4.fromMap(json.decode(str));

  factory Data4.fromMap(Map<String, dynamic> json) => Data4(
        token: json["token"],
        id: json["id"],
        numOfferApplied: json["num_offer_applied"],
        type: json["type"],
      );
}
