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
  DataLogin data;
  String message;

  factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        success: json["success"],
        data: DataLogin.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataLogin {
  DataLogin({
    required this.token,
    required this.id,
    required this.numOfferApplied,
    required this.type,
  });

  String token;
  int id;
  int numOfferApplied;
  String type;

  factory DataLogin.fromJson(String str) => DataLogin.fromMap(json.decode(str));

  factory DataLogin.fromMap(Map<String, dynamic> json) => DataLogin(
        token: json["token"],
        id: json["id"],
        numOfferApplied: json["num_offer_applied"],
        type: json["type"],
      );
}
