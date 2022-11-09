import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trabajo_flutter/models/user.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class UsersServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';
  final List<Datum4> users = [];
  User? user;

  bool isLoading = true;

  UsersServices() {
    loadUsers();
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

  Future<User> loadUser() async {
    String? token = await LoginServices().readToken();
    String? id = LoginServices().readId().toString();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/user', {'id': id});
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> userMap = json.decode(resp.body);

    user = User.fromMap(userMap);
    /*
    userMap.forEach((key, value) {
      final List<dynamic> usersMap1 = value;
      for (int i = 0; i < usersMap1.length; i++) {
        final tempUser = User.fromMap(usersMap1[i]);

        tempUser;
      }
      
});
*/
    isLoading = false;
    notifyListeners();
    return user!;
  }
}
