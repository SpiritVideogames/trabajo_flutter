// To parse required this JSON data, do
//
//     final users = usersFromMap(jsonString);

// ignore_for_file: non_constant_identifier_names

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
    this.firstname,
    this.secondname,
    this.company_id,
    this.actived,
    this.email,
    this.type,
    this.email_confirmed,
    this.deleted,
    this.iscontact,
    this.created_at,
    this.company,
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

  factory DataUsers.fromJson(String str) => DataUsers.fromMap(json.decode(str));

  factory DataUsers.fromMap(Map<String, dynamic> json) => DataUsers(
        id: json["id"],
        firstname: json["firstname"],
        secondname: json["secondname"],
        company_id: json["cicle_id"],
        actived: json["actived"],
        email: json["email"],
        type: json["type"],
        email_confirmed: json["num_offer_applied"],
        deleted: json["deleted"],
        iscontact: json["created_at_at"],
        created_at: json["email_verified_at"],
        company: json["updated_at"],
      );
}
