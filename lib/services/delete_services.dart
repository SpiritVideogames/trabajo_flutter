import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class DeleteServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  DeleteServices() {}

  postDelete(String user_id) async {
    String? token = await LoginServices().readToken();

    final url = Uri.http(
        _baseUrl, '/public/api/deleted/$user_id', {'user_id': user_id});
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> delete = json.decode(response.body);

    var id;
    var resp;
    if (delete.containsValue(true)) {
      delete.forEach((key, value) {
        if (key == 'data') {
          id = value['id'].toString();
          resp = id;
        }
      });
    } else {
      String? error = '';

      error = 'Error to activate';

      resp = error;
    }
    return resp;
  }
}
