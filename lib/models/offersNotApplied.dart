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
  List<DataOffersNotApplied> data;
  String message;

  factory OffersNotApplied.fromJson(String str) =>
      OffersNotApplied.fromMap(json.decode(str));

  factory OffersNotApplied.fromMap(Map<String, dynamic> json) =>
      OffersNotApplied(
        success: json["success"],
        data: List<DataOffersNotApplied>.from(
            json["data"].map((x) => DataOffersNotApplied.fromMap(x))),
        message: json["message"],
      );
}

class DataOffersNotApplied {
  DataOffersNotApplied({
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

  factory DataOffersNotApplied.fromJson(String str) =>
      DataOffersNotApplied.fromMap(json.decode(str));

  factory DataOffersNotApplied.fromMap(Map<String, dynamic> json) =>
      DataOffersNotApplied(
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
