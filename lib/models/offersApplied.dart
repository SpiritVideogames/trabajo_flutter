// To parse required this JSON data, do
//
//     final offersApplied = offersAppliedFromMap(jsonString);

import 'dart:convert';

class OffersApplied {
  OffersApplied({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<Datum> data;
  String message;

  factory OffersApplied.fromJson(String str) =>
      OffersApplied.fromMap(json.decode(str));

  factory OffersApplied.fromMap(Map<String, dynamic> json) => OffersApplied(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        message: json["message"],
      );
}

class Datum {
  Datum({
    required this.id,
    required this.headline,
    required this.description,
    required this.cicleId,
    required this.cicleName,
    required this.dateMax,
    required this.numCandidates,
    required this.deleted,
  });

  int id;
  String headline;
  String description;
  int cicleId;
  String cicleName;
  String dateMax;
  int numCandidates;
  int deleted;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        headline: json["headline"],
        description: json["description"],
        cicleId: json["cicle_id"],
        cicleName: json["cicle_name"],
        dateMax: json["date_max"],
        numCandidates: json["num_candidates"],
        deleted: json["deleted"],
      );
}
