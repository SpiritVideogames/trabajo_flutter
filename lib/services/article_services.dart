import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

class ArticleServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  late DataArticle selectedArticle = DataArticle();
  final storage = FlutterSecureStorage();

  bool isLoading = true;

  ArticleServices() {
    loadArticle();
  }

  Future loadArticle() async {
    String? token = await LoginServices().readToken();
    int? id = await LoginServices().readId();

    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/mostrarArt', {'id': id});
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> ArticlesMap = json.decode(resp.body);

    print(ArticlesMap);
    ArticlesMap.forEach((key, value) {
      if (key == "data") {
        final tempArticle = DataArticle.fromMap(value);

        selectedArticle = tempArticle;
        storage.write(key: 'id', value: selectedArticle.id.toString());
      }
    });

    isLoading = false;
    notifyListeners();
    return selectedArticle;
  }

  Future<int> readId() async {
    String? i = await storage.read(key: 'idCompany');
    return int.parse(i!);
  }
}
