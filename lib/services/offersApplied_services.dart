import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'login_services.dart';

class OffersAppliedServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  final List<Datum2> offersApplied = [];

  OffersAppliedServices() {}

  getOffersApplied(String user_id, String offer_id) async {
    String? token = await LoginServices().readToken();

    final url = Uri.http(_baseUrl, '/public/api/offersApplied/$user_id');
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> offersAppliedMap = json.decode(response.body);

    offersAppliedMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> offersAppliedMap1 = value;
        for (int i = 0; i < offersAppliedMap1.length; i++) {
          final tempOfferApplied = Datum2.fromMap(offersAppliedMap1[i]);

          offersApplied.add(tempOfferApplied);
        }
      }
    });
  }
}
