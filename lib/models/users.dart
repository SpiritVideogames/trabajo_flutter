// To parse this JSON datum2, do
//
//     final users = usersFromMap(jsonString);

import 'dart:convert';

class Users {
  Users({
    required this.success,
    required this.datum2,
    required this.message,
  });

  bool success;
  List<Datum2> datum2;
  String message;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        success: json["success"],
        datum2: List<Datum2>.from(json["datum2"].map((x) => Datum2.fromMap(x))),
        message: json["message"],
      );
}

class Datum2 {
  Datum2({
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

  factory Datum2.fromJson(String str) => Datum2.fromMap(json.decode(str));

  factory Datum2.fromMap(Map<String, dynamic> json) => Datum2(
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
