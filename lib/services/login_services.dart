import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  final storage = FlutterSecureStorage();

  LoginServices() {}

  postLogin(String email, String password) async {
    final url = Uri.http(
        _baseUrl, '/public/api/login', {'email': email, 'password': password});

    final response = await http
        .post(url, headers: {HttpHeaders.acceptHeader: 'application/json'});

    var type;
    var error;
    var resp;
    final Map<String, dynamic> login = json.decode(response.body);
    if (login.containsValue(true)) {
      login.forEach((key, value) {
        if (key == 'data') {
          storage.write(key: 'token', value: value['token']);
          storage.write(key: 'id', value: value['id'].toString());
          type = value['type'];
          if (value['actived'] == 1) {
            resp = type;
          } else {
            error = 'This account is not actived';

            resp = error;
          }
        }
      });
    } else {
      String? error = '';

      error = 'Error to login. Check email or password';

      resp = error;
    }
    return resp;
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<int> readId() async {
    String? i = await storage.read(key: 'id');
    return int.parse(i!);
  }
}
