// To parse this JSON data, do
//
//     final ordersCompany = ordersCompanyFromMap(jsonString);

import 'dart:convert';

class OrdersCompany {
  OrdersCompany({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<DataOrdersCompany> data;
  String message;

  factory OrdersCompany.fromJson(String str) =>
      OrdersCompany.fromMap(json.decode(str));

  factory OrdersCompany.fromMap(Map<String, dynamic> json) => OrdersCompany(
        success: json["success"],
        data: List<DataOrdersCompany>.from(
            json["data"].map((x) => DataOrdersCompany.fromMap(x))),
        message: json["message"],
      );
}

class DataOrdersCompany {
  DataOrdersCompany({
    required this.id,
    required this.originCompanyId,
    required this.orderLines,
    required this.issueDate,
  });

  int id;
  int originCompanyId;
  List<OrderLine> orderLines;
  DateTime issueDate;

  factory DataOrdersCompany.fromJson(String str) =>
      DataOrdersCompany.fromMap(json.decode(str));

  factory DataOrdersCompany.fromMap(Map<String, dynamic> json) =>
      DataOrdersCompany(
        id: json["id"],
        originCompanyId: json["origin_company_id"],
        orderLines: List<OrderLine>.from(
            json["order_lines"].map((x) => OrderLine.fromMap(x))),
        issueDate: DateTime.parse(json["issue_date"]),
      );
}

class OrderLine {
  OrderLine({
    required this.id,
    required this.orderId,
    required this.orderLineNum,
    required this.issueDate,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.articlesLine,
  });

  int id;
  int orderId;
  String orderLineNum;
  DateTime issueDate;
  int deleted;
  DateTime createdAt;
  DateTime updatedAt;
  List<ArticlesLine> articlesLine;

  factory OrderLine.fromJson(String str) => OrderLine.fromMap(json.decode(str));

  factory OrderLine.fromMap(Map<String, dynamic> json) => OrderLine(
        id: json["id"],
        orderId: json["order_id"],
        orderLineNum: json["order_line_num"],
        issueDate: DateTime.parse(json["issue_date"]),
        deleted: json["deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        articlesLine: List<ArticlesLine>.from(
            json["articles_line"].map((x) => ArticlesLine.fromMap(x))),
      );
}

class ArticlesLine {
  ArticlesLine({
    required this.id,
    required this.articleId,
    required this.numArticles,
    required this.orderLinesId,
    required this.deleted,
    required this.updatedAt,
    required this.createdAt,
    required this.articleCompany,
  });

  int id;
  int articleId;
  int numArticles;
  int orderLinesId;
  int deleted;
  DateTime updatedAt;
  DateTime createdAt;
  ArticleCompany articleCompany;

  factory ArticlesLine.fromJson(String str) =>
      ArticlesLine.fromMap(json.decode(str));

  factory ArticlesLine.fromMap(Map<String, dynamic> json) => ArticlesLine(
        id: json["id"],
        articleId: json["article_id"],
        numArticles: json["num_articles"],
        orderLinesId: json["order_lines_id"],
        deleted: json["deleted"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        articleCompany: ArticleCompany.fromMap(json["article"]),
      );
}

class ArticleCompany {
  ArticleCompany({
    required this.id,
    required this.name,
    required this.description,
    required this.priceMin,
    required this.priceMax,
    required this.colorName,
    required this.weight,
    required this.sizeArticle,
    required this.familyId,
    required this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  Name name;
  Description description;
  String priceMin;
  String priceMax;
  ColorName colorName;
  String weight;
  SizeArticle sizeArticle;
  int familyId;
  int deleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ArticleCompany.fromJson(String str) =>
      ArticleCompany.fromMap(json.decode(str));

  factory ArticleCompany.fromMap(Map<String, dynamic> json) => ArticleCompany(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        description: descriptionValues.map[json["description"]]!,
        priceMin: json["price_min"],
        priceMax: json["price_max"],
        colorName: colorNameValues.map[json["color_name"]]!,
        weight: json["weight"],
        sizeArticle: sizeArticleValues.map[json["sizeArticle"]]!,
        familyId: json["family_id"],
        deleted: json["deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}

enum ColorName { OCRE, VERDE, BLANCO, AMARILLO, AZUL, EMPTY }

final colorNameValues = EnumValues({
  "Amarillo": ColorName.AMARILLO,
  "Azul": ColorName.AZUL,
  "Blanco": ColorName.BLANCO,
  "": ColorName.EMPTY,
  "Ocre": ColorName.OCRE,
  "Verde": ColorName.VERDE
});

enum Description {
  PINTURA_OCRE_25_KG,
  AZULEJO_VERDE_60_X60,
  PINTURA_BLANCA_12_KG,
  PINTURA_AMARILLA_2_KG,
  AZULEJO_AZUL_15_X15,
  BROCHA_5_CM
}

final descriptionValues = EnumValues({
  "Azulejo Azul 15x15": Description.AZULEJO_AZUL_15_X15,
  "Azulejo Verde 60x60": Description.AZULEJO_VERDE_60_X60,
  "Brocha 5cm": Description.BROCHA_5_CM,
  "Pintura Amarilla 2Kg": Description.PINTURA_AMARILLA_2_KG,
  "Pintura blanca 1/2 Kg": Description.PINTURA_BLANCA_12_KG,
  "Pintura Ocre 25Kg": Description.PINTURA_OCRE_25_KG
});

enum Name {
  PINT_OC_25,
  AZU_VER_6060,
  PINT_BL_05,
  PINT_AM_2,
  AZU_AZ_1515,
  BRO_5
}

final nameValues = EnumValues({
  "Azu_az_15_15": Name.AZU_AZ_1515,
  "Azu_ver_60_60": Name.AZU_VER_6060,
  "Bro_5": Name.BRO_5,
  "Pint_Am_2": Name.PINT_AM_2,
  "Pint_Bl_0_5": Name.PINT_BL_05,
  "Pint_Oc_25": Name.PINT_OC_25
});

enum SizeArticle { THE_250, THE_60_X60, EMPTY, THE_15_X15, THE_5_CM }

final sizeArticleValues = EnumValues({
  "": SizeArticle.EMPTY,
  "15x15": SizeArticle.THE_15_X15,
  "25,0": SizeArticle.THE_250,
  "5cm": SizeArticle.THE_5_CM,
  "60x60": SizeArticle.THE_60_X60
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
