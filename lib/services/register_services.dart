import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RegisterServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  final storage = FlutterSecureStorage();

  RegisterServices() {}

  postRegister(String firstname, String secondname, String email,
      String password, String c_password, String company_id) async {
    final url = Uri.http(_baseUrl, '/public/api/register', {
      'firstname': firstname,
      'secondname': secondname,
      'email': email,
      'password': password,
      'c_password': c_password,
      'company_id': company_id,
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
          storage.write(key: 'id', value: value['id'].toString());
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
    await storage.delete(key: 'id');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> readId() async {
    return await storage.read(key: 'id') ?? '';
  }
}
