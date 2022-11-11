import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'login_services.dart';

class OffersNotAppliedServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  final List<Datum3> offersNotApplied = [];

  OffersNotAppliedServices() {}

  getOffersNotApplied(String user_id, String offer_id) async {
    String? token = await LoginServices().readToken();

    final url = Uri.http(_baseUrl, '/public/api/offersNotApplied/$user_id');
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> offersNotAppliedMap = json.decode(response.body);

    offersNotAppliedMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> offersNotAppliedMap1 = value;
        for (int i = 0; i < offersNotAppliedMap1.length; i++) {
          final tempOfferNotApplied = Datum3.fromMap(offersNotAppliedMap1[i]);

          offersNotApplied.add(tempOfferNotApplied);
        }
      }
    });
  }
}
