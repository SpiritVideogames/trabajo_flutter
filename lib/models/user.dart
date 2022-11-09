import 'dart:convert';

class User {
  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.cicleId,
    required this.actived,
    required this.email,
    required this.emailVerifiedAt,
    required this.type,
    required this.numOfferApplied,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String surname;
  int cicleId;
  int actived;
  String email;
  DateTime emailVerifiedAt;
  String type;
  int numOfferApplied;
  int deleted;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        cicleId: json["cicle_id"],
        actived: json["actived"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        type: json["type"],
        numOfferApplied: json["num_offer_applied"],
        deleted: json["deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "surname": surname,
        "cicle_id": cicleId,
        "actived": actived,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "type": type,
        "num_offer_applied": numOfferApplied,
        "deleted": deleted,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
