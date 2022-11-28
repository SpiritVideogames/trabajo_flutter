// To parse required this JSON data, do
//
//     final register = registerFromMap(jsonString);

import 'dart:convert';

class Register {
  Register({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  DataRegister data;
  String message;

  factory Register.fromJson(String str) => Register.fromMap(json.decode(str));

  factory Register.fromMap(Map<String, dynamic> json) => Register(
        success: json["success"],
        data: DataRegister.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataRegister {
  DataRegister({
    required this.token,
    required this.firstname,
    required this.secondname,
  });

  String token;
  String firstname;
  String secondname;

  factory DataRegister.fromJson(String str) =>
      DataRegister.fromMap(json.decode(str));

  factory DataRegister.fromMap(Map<String, dynamic> json) => DataRegister(
        token: json["token"],
        firstname: json["firstname"],
        secondname: json["secondname"],
      );
}
