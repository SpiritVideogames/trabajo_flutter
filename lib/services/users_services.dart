import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trabajo_flutter/providers/login_api_provider.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import '../providers/login_api_provider.dart';

class UsersServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';
  final List<Datum3> users = [];
  bool isLoading = true;

  UsersServices() {
    loadUsers();
  }

  Future loadUsers() async {
    String? token = await LoginApiProvider().readToken();

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
          final tempUser = Datum3.fromMap(usersMap1[i]);

          users.add(tempUser);
        }
      }
    });

    isLoading = false;
    notifyListeners();
    return users;
  }
}
