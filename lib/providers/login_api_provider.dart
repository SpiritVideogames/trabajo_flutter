import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:trabajo_flutter/models/models.dart';

class LoginApiProvider extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  late String loginToken;

  postRegister(String firstname, String secondname, String email,
      String password, String c_password, String company_id) async {
    final url = Uri.http(_baseUrl, '/public/api/register', {
      'firstname': firstname,
      'secondname': secondname,
      'email': email,
      'password': password,
      'c_password': c_password,
      'company_id': company_id
    });

    final response = await http
        .post(url, headers: {HttpHeaders.acceptHeader: 'application/json'});
    final register = Register.fromJson(response.body);

    return register.data4.token;
  }

  postLogin(String email, String password) async {
    final url = Uri.http(
        _baseUrl, '/public/api/login', {'email': email, 'password': password});

    final response = await http
        .post(url, headers: {HttpHeaders.acceptHeader: 'application/json'});

    //final login = Login.fromJson(response.body);
    final Map<String, dynamic> login = json.decode(response.body);
    if (login.containsKey('idToken')) {
      return null;
    } else {
      return login['error'];
    }
  }

  postActivate(String user_id, String token) async {
    final url =
        Uri.http(_baseUrl, '/public/api/activate', {'user_id': user_id});

    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final activate = Activate.fromJson(response.body);

    return activate.data;
  }

  postDeactivate(String user_id, String token) async {
    final url =
        Uri.http(_baseUrl, '/public/api/deactivate', {'user_id': user_id});

    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final deactivate = Deactivate.fromJson(response.body);

    return deactivate.data2;
  }

  getUsers(String token) async {
    final url = Uri.http(_baseUrl, '/public/api/users');

    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final users = Users.fromJson(response.body);

    return users.datum2;
  }

  getCompanies() async {
    final url = Uri.http(_baseUrl, '/public/api/companies');

    final response = await http.get(url);
    final companies = Companies.fromJson(response.body);

    return companies.datum;
  }

  getUser(String user_id, String token) async {
    final url =
        Uri.http(_baseUrl, '/public/api/user/$user_id', {'user_id': user_id});

    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final user = User.fromJson(response.body);

    return user.data6;
  }

  postDeleted(String user_id, String token) async {
    final url = Uri.http(
        _baseUrl, '/public/api/user/deleted/$user_id', {'user_id': user_id});

    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final deleted = Deleted.fromJson(response.body);

    return deleted.data;
  }

  postUpdated(String user_id, String firstname, String secondname, String email,
      String password, String company_id, String token) async {
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
    final updated = Updated.fromJson(response.body);

    return updated.data5;
  }
}
