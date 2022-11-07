// To parse required this JSON data, do
//
//     final users = usersFromMap(jsonString);

import 'dart:convert';

class Users {
  Users({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<Datum4> data;
  String message;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        success: json["success"],
        data: List<Datum4>.from(json["data"].map((x) => Datum4.fromMap(x))),
        message: json["message"],
      );
}

class Datum4 {
  Datum4({
    required this.id,
    required this.name,
    required this.surname,
    required this.cicleId,
    required this.actived,
    required this.email,
    required this.type,
    required this.numOfferApplied,
    required this.deleted,
    required this.createdAt,
  });

  int id;
  String name;
  String surname;
  int cicleId;
  int actived;
  String email;
  String type;
  int numOfferApplied;
  int deleted;
  String createdAt;

  factory Datum4.fromJson(String str) => Datum4.fromMap(json.decode(str));

  factory Datum4.fromMap(Map<String, dynamic> json) => Datum4(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        cicleId: json["cicle_id"],
        actived: json["actived"],
        email: json["email"],
        type: json["type"],
        numOfferApplied: json["num_offer_applied"],
        deleted: json["deleted"],
        createdAt: json["created_at"],
      );
}
