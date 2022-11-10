import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class ConfirmServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  ConfirmServices() {}

  postConfirm(String user_id) async {
    String? token = await LoginServices().readToken();

    final url = Uri.http(_baseUrl, '/public/api/confirm', {'user_id': user_id});
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> confirm = json.decode(response.body);

    var id;
    var resp;
    if (confirm.containsValue(true)) {
      confirm.forEach((key, value) {
        if (key == 'data') {
          id = value['id'].toString();
          resp = id;
        }
      });
    } else {
      String? error = '';

      error = 'Error to confirm';

      resp = error;
    }
    return resp;
  }
}
