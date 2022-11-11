import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class AppliedServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  AppliedServices() {}

  postApplied(String user_id, String offer_id) async {
    String? token = await LoginServices().readToken();

    final url = Uri.http(_baseUrl, '/public/api/applied',
        {'user_id': user_id, 'offer_id': offer_id});
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> applied = json.decode(response.body);

    var id;
    var resp;
    if (applied.containsValue(true)) {
      applied.forEach((key, value) {
        if (key == 'data') {
          id = value['id'].toString();
          resp = id;
        }
      });
    } else {
      String? error = '';

      error = 'Error to apply';

      resp = error;
    }
    return resp;
  }
}
