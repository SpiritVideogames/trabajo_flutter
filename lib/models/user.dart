import 'dart:convert';

// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class User {
  User({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  DataUser data;
  String message;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        success: json["success"],
        data: DataUser.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data.toMap(),
        "message": message,
      };
}

class DataUser {
  DataUser({
    this.id,
    this.name,
    this.surname,
    this.cicleId,
    this.actived,
    this.email,
    this.numOfferApplied,
    this.type,
    this.deleted,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? surname;
  int? cicleId;
  int? actived;
  String? email;
  int? numOfferApplied;
  String? type;
  int? deleted;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  factory DataUser.fromJson(String str) => DataUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataUser.fromMap(Map<String, dynamic> json) => DataUser(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        cicleId: json["cicle_id"],
        actived: json["actived"],
        email: json["email"],
        numOfferApplied: json["num_offer_applied"],
        type: json["type"],
        deleted: json["deleted"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "surname": surname,
        "cicle_id": cicleId,
        "actived": actived,
        "email": email,
        "num_offer_applied": numOfferApplied,
        "type": type,
        "deleted": deleted,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
