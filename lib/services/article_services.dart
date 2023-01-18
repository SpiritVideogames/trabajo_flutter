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
  final storage = const FlutterSecureStorage();

  bool isLoading = true;

  ArticleServices();

  Future loadArticle(String id) async {
    String? token = await LoginServices().readToken();

    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/mostrarArt', {'id': id});
    final resp = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articlesMap = json.decode(resp.body);

    articlesMap.forEach((key, value) {
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
    String? i = await storage.read(key: 'id');
    return int.parse(i!);
  }
}
