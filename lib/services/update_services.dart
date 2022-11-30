import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

class UpdateServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  UpdateServices() {}

  postUpdate(String user_id, String firstname, String secondname, String email,
      String password, String company_id) async {
    String? token = await LoginServices().readToken();

    final url = Uri.http(_baseUrl, '/public/api/user/updated/$user_id', {
      'user_id': user_id,
      'firstname': firstname,
      'secondname': secondname,
      'email': email,
      'password': password,
      'company_id': company_id
    });
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> productUpdate = json.decode(response.body);

    var resp;
    if (productUpdate.containsValue(true)) {
    } else {
      String? error = '';

      error = 'Error to update';

      resp = error;
    }
    return resp;
  }
}
