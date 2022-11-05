import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

class LoginServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  final List<Data4> login = [];
  bool isLoading = true;

  LoginServices(String email, String password) {
    loadLogin(email, password);
  }

  Future loadLogin(String email, String password) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
        _baseUrl, '/public/api/login', {'email': email, 'password': password});
    final resp = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
    });

    final Map<String, dynamic> loginMap = json.decode(resp.body);

    loginMap.forEach((key, value) {
      if (key == "data") {
        final tempLogin = Data4.fromMap(value);

        login.add(tempLogin);
      }
    });

    isLoading = false;
    notifyListeners();
    return login;
  }
}
