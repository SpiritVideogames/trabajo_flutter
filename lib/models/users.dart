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
  List<DataUsers> data;
  String message;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        success: json["success"],
        data:
            List<DataUsers>.from(json["data"].map((x) => DataUsers.fromMap(x))),
        message: json["message"],
      );
}

class DataUsers {
  DataUsers({
    this.id,
    this.name,
    this.surname,
    this.cicleId,
    this.actived,
    this.email,
    this.type,
    this.numOfferApplied,
    this.deleted,
    this.createdAt,
    this.emailVerifiedAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? surname;
  int? cicleId;
  int? actived;
  String? email;
  String? type;
  int? numOfferApplied;
  int? deleted;
  String? createdAt;
  String? updatedAt;
  String? emailVerifiedAt;

  factory DataUsers.fromJson(String str) => DataUsers.fromMap(json.decode(str));

  factory DataUsers.fromMap(Map<String, dynamic> json) => DataUsers(
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
        emailVerifiedAt: json["email_verified_at"],
        updatedAt: json["updated_at"],
      );

  DataUsers copy() => DataUsers(
        actived: this.actived,
        cicleId: this.cicleId,
        createdAt: this.createdAt,
        deleted: this.deleted,
        email: this.email,
        id: this.id,
        name: this.name,
        numOfferApplied: this.numOfferApplied,
        surname: this.surname,
        type: this.type,
        emailVerifiedAt: this.emailVerifiedAt,
        updatedAt: this.updatedAt,
      );
}
