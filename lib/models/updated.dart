// To parse required this JSON data5, do
//
//     final updated = updatedFromMap(jsonString);

import 'dart:convert';

class Updated {
  Updated({
    required this.success,
    required this.data5,
    required this.message,
  });

  bool success;
  Data5 data5;
  String message;

  factory Updated.fromJson(String str) => Updated.fromMap(json.decode(str));

  factory Updated.fromMap(Map<String, dynamic> json) => Updated(
        success: json["success"],
        data5: Data5.fromMap(json["data"]),
        message: json["message"],
      );
}

class Data5 {
  Data5({
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
  String companyId;
  int actived;
  String email;
  String type;
  int emailConfirmed;
  int deleted;
  int iscontact;
  String company;
  String createdAt;

  factory Data5.fromJson(String str) => Data5.fromMap(json.decode(str));

  factory Data5.fromMap(Map<String, dynamic> json) => Data5(
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
