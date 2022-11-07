// To parse required this JSON data, do
//
//     final offersNotApplied = offersNotAppliedFromMap(jsonString);

import 'dart:convert';

class OffersNotApplied {
  OffersNotApplied({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<Datum3> data;
  String message;

  factory OffersNotApplied.fromJson(String str) =>
      OffersNotApplied.fromMap(json.decode(str));

  factory OffersNotApplied.fromMap(Map<String, dynamic> json) =>
      OffersNotApplied(
        success: json["success"],
        data: List<Datum3>.from(json["data"].map((x) => Datum3.fromMap(x))),
        message: json["message"],
      );
}

class Datum3 {
  Datum3({
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
  String? headline;
  String? description;
  int? cicleId;
  String? cicleName;
  String? dateMax;
  int? numCandidates;
  int? deleted;

  factory Datum3.fromJson(String str) => Datum3.fromMap(json.decode(str));

  factory Datum3.fromMap(Map<String, dynamic> json) => Datum3(
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
