// To parse required this JSON dataUpdate, do
//
//     final update = updateFromMap(jsonString);

import 'dart:convert';

class Update {
  Update({
    required this.success,
    required this.dataUpdate,
    required this.message,
  });

  bool success;
  DataUpdate dataUpdate;
  String message;

  factory Update.fromJson(String str) => Update.fromMap(json.decode(str));

  factory Update.fromMap(Map<String, dynamic> json) => Update(
        success: json["success"],
        dataUpdate: DataUpdate.fromMap(json["dataUpdate"]),
        message: json["message"],
      );
}

class DataUpdate {
  DataUpdate({
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

  factory DataUpdate.fromJson(String str) =>
      DataUpdate.fromMap(json.decode(str));

  factory DataUpdate.fromMap(Map<String, dynamic> json) => DataUpdate(
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
