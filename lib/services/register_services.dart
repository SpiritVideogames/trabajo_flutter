import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RegisterServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  final storage = FlutterSecureStorage();

  RegisterServices() {}

  postRegister(String name, String surname, String email, String password,
      String c_password, int cicle_id) async {
    print(cicle_id);
    final url = Uri.http(_baseUrl, '/public/api/register', {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'c_password': c_password,
      'cicle_id': cicle_id.toString(),
    });
    final response = await http
        .post(url, headers: {HttpHeaders.acceptHeader: 'application/json'});

    var error;
    var resp;
    final Map<String, dynamic> register = json.decode(response.body);
    if (register.containsValue(true)) {
      register.forEach((key, value) {
        if (key == 'data') {
          storage.write(key: 'token', value: value['token']);
        }
      });
    } else {
      String? error = '';

      error = 'Error to register. The email is already taken';

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
}
