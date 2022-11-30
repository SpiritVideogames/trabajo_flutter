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

  factory User.fromMap(Map<String, dynamic> json) => User(
        success: json["success"],
        data: DataUser.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataUser {
  DataUser({
    this.id,
    this.firstname,
    this.secondname,
    this.company_id,
    this.actived,
    this.email,
    this.type,
    this.email_confirmed,
    this.deleted,
    this.iscontact,
    this.company,
    this.created_at,
  });

  int? id;
  String? firstname;
  String? secondname;
  int? company_id;
  int? actived;
  String? email;
  String? type;
  int? email_confirmed;
  int? deleted;
  int? iscontact;
  String? company;
  String? created_at;

  factory DataUser.fromJson(String str) => DataUser.fromMap(json.decode(str));

  factory DataUser.fromMap(Map<String, dynamic> json) => DataUser(
        id: json["id"],
        firstname: json["firstname"],
        secondname: json["secondname"],
        company_id: json["company_id"],
        actived: json["actived"],
        email: json["email"],
        type: json["type"],
        email_confirmed: json["email_confirmed"],
        deleted: json["deleted"],
        iscontact: json["iscontact"],
        company: json["company"],
        created_at: json["created_at"],
      );
}
