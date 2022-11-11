import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trabajo_flutter/models/user.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class UserServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  late Datum5 selectedUser = Datum5();

  bool isLoading = true;

  UserServices() {
    loadUser();
  }

  Future loadUser() async {
    String? token = await LoginServices().readToken();
    int? id = await LoginServices().readId();

    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/usuario/$id');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> usersMap = json.decode(resp.body);
    print(resp.body);

    usersMap.forEach((key, value) {
      if (key == "data") {
        final tempUser = Datum5.fromMap(value);

        selectedUser = tempUser;
      }
    });

    print(selectedUser.id);

    isLoading = false;
    notifyListeners();
    return selectedUser;
  }
}
