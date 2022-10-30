import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:trabajo_flutter/models/models.dart';

class LoginApiProvider extends ChangeNotifier {
  final String _baseUrl = 'http://semillero.allsites.es/public/api';

  postRegister(String firstname, String secondname, String email,
      String password, String c_password, int id_company) async {
    final url = Uri.https(_baseUrl, '/register', {
      'firstname': firstname,
      'secondname': secondname,
      'email': email,
      'password': password,
      'c_password': c_password,
      'id_company': id_company
    });

    final response = await http.get(url);
    final register = Register.fromJson(response.body);

    return register.data4.token;
  }

  postLogin(String email, String password) async {
    final url =
        Uri.https(_baseUrl, '/login', {'email': email, 'password': password});

    final response = await http.get(url);
    final login = Login.fromJson(response.body);

    return login.data3;
  }

  postActivate(String user_id, Data3 data3) async {
    String token = data3.token;

    final url = Uri.https(_baseUrl, '/activate', {'user_id': user_id});

    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final activate = Activate.fromJson(response.body);

    return activate.data;
  }

  postDeactivate(String user_id, Data3 data3) async {
    String token = data3.token;

    final url = Uri.https(_baseUrl, '/deactivate', {'user_id': user_id});

    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final deactivate = Deactivate.fromJson(response.body);

    return deactivate.data2;
  }

  getUsers(Data3 data3) async {
    String token = data3.token;

    final url = Uri.https(_baseUrl, '/users');

    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final users = Users.fromJson(response.body);

    return users.datum2;
  }

  getCompanies(String user_id, Data3 data3) async {
    String token = data3.token;

    final url = Uri.https(_baseUrl, '/companies');

    final response = await http.get(url);
    final companies = Companies.fromJson(response.body);

    return companies.datum;
  }

  getUser(String user_id, Data3 data3) async {
    String token = data3.token;

    final url = Uri.https(_baseUrl, '/user/$user_id', {'user_id': user_id});

    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final user = User.fromJson(response.body);

    return user.data6;
  }

  postDeleted(String user_id, Data3 data3) async {
    String token = data3.token;

    final url = Uri.https(_baseUrl, '/deleted/$user_id', {'user_id': user_id});

    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final deleted = Deleted.fromJson(response.body);

    return deleted.data;
  }

  postUpdated(String user_id, String firstname, String secondname, String email,
      String password, int id_company) async {
    final url = Uri.https(_baseUrl, '/updated', {
      'user_id': user_id,
      'firstname': firstname,
      'secondname': secondname,
      'email': email,
      'password': password,
      'id_company': id_company
    });

    final response = await http.get(url);
    final updated = Updated.fromJson(response.body);

    return updated.data5;
  }
}
