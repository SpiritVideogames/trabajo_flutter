import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class UsersServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';
  final List<DataUsers> users = [];

  bool isLoading = true;

  UsersServices();

  Future loadUsers() async {
    users.clear();
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
          final tempUser = DataUsers.fromMap(usersMap1[i]);
          if (tempUser.deleted == 0) {
            users.add(tempUser);
          }
        }
      }
    });

    isLoading = false;
    notifyListeners();
    return users;
  }
}
