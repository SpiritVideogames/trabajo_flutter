// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class LogoutServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';
  bool isLoading = true;

  LogoutServices();

  getLogout() async {
    String? token = await LoginServices().readToken();

    final url = Uri.http(_baseUrl, '/public/api/logout');
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> logout = json.decode(response.body);

    var id;
    var resp;
    if (logout.containsValue(true)) {
      logout.forEach((key, value) {
        if (key == 'data') {
          id = value['id'].toString();
          resp = id;
        }
      });
    } else {
      String? error = '';

      error = 'Error to logout';

      resp = error;
    }
    return resp;
  }
}
