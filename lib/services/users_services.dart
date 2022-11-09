import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class UsersServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';
  final List<Datum4> users = [];
  final List<Datum4> user = [];

  bool isLoading = true;

  UsersServices() {
    loadUser();
  }

  Future loadUsers() async {
    String? token = await LoginServices().readToken();

    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/users');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> usersMap = json.decode(resp.body);

    usersMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> usersMap1 = value;
        for (int i = 0; i < usersMap1.length; i++) {
          final tempUser = Datum4.fromMap(usersMap1[i]);

          users.add(tempUser);
        }
      }
    });

    isLoading = false;
    notifyListeners();
    return users;
  }

  Future loadUser() async {
    int id = await LoginServices().readId();
    String? token = await LoginServices().readToken();

    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/users');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> usersMap = json.decode(resp.body);

    usersMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> usersMap1 = value;
        for (int i = 0; i < usersMap1.length; i++) {
          final tempUser = Datum4.fromMap(usersMap1[i]);

          users.add(tempUser);
        }
      }
    });

    for (int i = 0; i < users.length; i++) {
      if (users[i].id == id) {
        print(id);
        print(users[i].id);
        user.add(users[i]);
      }
    }
    print(user[0].name);
    isLoading = false;
    notifyListeners();
    return user;
  }
}
