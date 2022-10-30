// To parse required this JSON data6, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class User {
  User({
    required this.success,
    required this.data6,
    required this.message,
  });

  bool success;
  Data6 data6;
  String message;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) => User(
        success: json["success"],
        data6: Data6.fromMap(json["data6"]),
        message: json["message"],
      );
}

class Data6 {
  Data6({
    required this.id,
    required this.firstname,
    required this.secondname,
    required this.companyId,
    required this.actived,
    required this.email,
    required this.type,
    required this.emailConfirmed,
    required this.deleted,
    required this.iscontact,
    required this.company,
    required this.createdAt,
  });

  int id;
  String firstname;
  String secondname;
  int companyId;
  int actived;
  String email;
  String type;
  int emailConfirmed;
  int deleted;
  int iscontact;
  String company;
  String createdAt;

  factory Data6.fromJson(String str) => Data6.fromMap(json.decode(str));

  factory Data6.fromMap(Map<String, dynamic> json) => Data6(
        id: json["id"],
        firstname: json["firstname"],
        secondname: json["secondname"],
        companyId: json["company_id"],
        actived: json["actived"],
        email: json["email"],
        type: json["type"],
        emailConfirmed: json["email_confirmed"],
        deleted: json["deleted"],
        iscontact: json["iscontact"],
        company: json["company"],
        createdAt: json["created_at"],
      );
}
