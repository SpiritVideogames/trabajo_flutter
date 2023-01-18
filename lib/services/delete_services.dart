import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class DeleteServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  DeleteServices();

  postDelete(String userId) async {
    String? token = await LoginServices().readToken();

    final url =
        Uri.http(_baseUrl, '/public/api/deleted/$userId', {'user_id': userId});
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> delete = json.decode(response.body);

    String id;
    String resp = '';
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
