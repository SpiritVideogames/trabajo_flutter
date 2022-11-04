// To parse required this JSON data, do
//
//     final users = usersFromMap(jsonString);

import 'dart:convert';

class UsersTest {
  UsersTest({
    required this.id,
    required this.name,
    required this.surname,
    required this.cicleId,
    required this.actived,
    required this.email,
    required this.type,
    required this.numOfferApplied,
    required this.createdAt,
  });

  String? id;
  String name;
  String surname;
  int cicleId;
  int actived;
  String email;
  String type;
  int numOfferApplied;
  String createdAt;

  factory UsersTest.fromJson(String str) => UsersTest.fromMap(json.decode(str));

  factory UsersTest.fromMap(Map<String, dynamic> json) => UsersTest(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        cicleId: json["cicle_id"],
        actived: json["actived"],
        email: json["email"],
        type: json["type"],
        numOfferApplied: json["num_offer_applied"],
        createdAt: json["created_at"],
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
    required this.createdAt,
  });

  String? id;
  String name;
  String surname;
  int cicleId;
  int actived;
  String email;
  String type;
  int numOfferApplied;
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
        createdAt: json["created_at"],
      );
}
