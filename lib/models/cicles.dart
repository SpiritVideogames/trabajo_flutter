// To parse required this JSON data, do
//
//     final cicles = ciclesFromMap(jsonString);

import 'dart:convert';

class Cicles {
  Cicles({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<Datum> data;
  String message;

  factory Cicles.fromJson(String str) => Cicles.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cicles.fromMap(Map<String, dynamic> json) => Cicles(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "message": message,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.img,
  });

  int id;
  String name;
  String img;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        img: json["img"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "img": img,
      };
}
