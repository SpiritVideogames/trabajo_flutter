import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:trabajo_flutter/models/models.dart';

class LoginApiProvider extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  final storage = FlutterSecureStorage();
  late String loginToken;

  postRegister(String name, String surname, String email, String password,
      String c_password, String cicle_id) async {
    final url = Uri.http(_baseUrl, '/public/api/register', {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'c_password': c_password,
      'cicle_id': cicle_id
    });

    final response = await http
        .post(url, headers: {HttpHeaders.acceptHeader: 'application/json'});
    final register = Register.fromJson(response.body);

    return register.data;
  }

  postLogin(String email, String password) async {
    final url = Uri.http(
        _baseUrl, '/public/api/login', {'email': email, 'password': password});

    final response = await http
        .post(url, headers: {HttpHeaders.acceptHeader: 'application/json'});

    //final login = Login.fromJson(response.body);
    final Map<String, dynamic> login = json.decode(response.body);
    print(login.containsValue(true));

    if (login.containsValue(true)) {
      await storage.write(key: 'token', value: login['idToken']);
      login.forEach((key, value) {
        if (key == 'actived') {
          if (value == 1) {
            return null;
          } else {
            Map<String, String> error = {};
            login.forEach((key, value) {
              error.putIfAbsent(key, () => value.toString());
            });

            List errorStr = [];
            error.forEach((key, value) {
              errorStr.add(value);
            });

            return errorStr[0];
          }
        }
      });
    } else {
      Map<String, String> error = {};
      login.forEach((key, value) {
        error.putIfAbsent(key, () => value.toString());
      });

      List errorStr = [];
      error.forEach((key, value) {
        errorStr.add(value);
      });

      return errorStr[0];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
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

  getUsers(String token) async {
    final url = Uri.http(_baseUrl, '/public/api/users');

    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    //final users = Users.fromJson(response.body);
    final Map<String, String> listUsers = json.decode(response.body);
    return listUsers;
  }

  postApplied(String user_id, String offer_id, String token) async {
    final url = Uri.http(_baseUrl, '/public/api/applied',
        {'user_id': user_id, 'offer_id': offer_id});

    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final applied = Applied.fromJson(response.body);

    return applied.data;
  }

  postUnapplied(String user_id, String offer_id, String token) async {
    final url = Uri.http(_baseUrl, '/public/api/unapplied',
        {'user_id': user_id, 'offer_id': offer_id});

    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final unapplied = Unapplied.fromJson(response.body);

    return unapplied.data;
  }

  getOffersApplied(String user_id, String token) async {
    final url = Uri.http(_baseUrl, '/public/api/offersApplied/$user_id');

    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final offersApplied = OffersApplied.fromJson(response.body);

    return offersApplied.data;
  }

  getOffersNotApplied(String user_id, String token) async {
    final url = Uri.http(_baseUrl, '/public/api/offersNotApplied/$user_id');

    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final offersNotApplied = OffersNotApplied.fromJson(response.body);

    return offersNotApplied.data;
  }

  postConfirm(String user_id, String token) async {
    final url = Uri.http(_baseUrl, '/public/api/confirm', {'user_id': user_id});

    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final confirm = Confirm.fromJson(response.body);

    return confirm.data;
  }
}
