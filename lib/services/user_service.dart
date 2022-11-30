import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trabajo_flutter/models/user.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class UserServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  late DataUser selectedUser = DataUser();
  final storage = FlutterSecureStorage();

  bool isLoading = true;

  UserServices() {
    loadUser();
  }

  Future loadUser() async {
    String? token = await LoginServices().readToken();
    int? id = await LoginServices().readId();

    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/user/$id');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> usersMap = json.decode(resp.body);

    usersMap.forEach((key, value) {
      if (key == "data") {
        final tempUser = DataUser.fromMap(value);

        selectedUser = tempUser;
        storage.write(
            key: 'idCompany', value: selectedUser.company_id.toString());
      }
    });

    isLoading = false;
    notifyListeners();
    return selectedUser;
  }

  Future<int> readIdCompany() async {
    String? i = await storage.read(key: 'idCompany');
    return int.parse(i!);
  }
}
