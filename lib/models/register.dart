// To parse this JSON data4, do
//
//     final register = registerFromMap(jsonString);

import 'dart:convert';

class Register {
  Register({
    required this.success,
    required this.data4,
    required this.message,
  });

  bool success;
  Data4 data4;
  String message;

  factory Register.fromJson(String str) => Register.fromMap(json.decode(str));

  factory Register.fromMap(Map<String, dynamic> json) => Register(
        success: json["success"],
        data4: Data4.fromMap(json["data4"]),
        message: json["message"],
      );
}

class Data4 {
  Data4({
    required this.token,
    required this.firstname,
    required this.secondname,
  });

  String token;
  String firstname;
  String secondname;

  factory Data4.fromJson(String str) => Data4.fromMap(json.decode(str));

  factory Data4.fromMap(Map<String, dynamic> json) => Data4(
        token: json["token"],
        firstname: json["firstname"],
        secondname: json["secondname"],
      );
}
