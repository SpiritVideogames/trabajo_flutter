import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

class ArticlesServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';
  final List<DataArticles> articles = [];
  List<DataProductsCompany> products = [];

  bool isLoading = true;

  ArticlesServices();

  Future loadArticles() async {
    articles.clear();
    String? token = await LoginServices().readToken();

    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/articles');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articlesMap = json.decode(resp.body);

    articlesMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> articlesMap1 = value;
        for (int i = 0; i < articlesMap1.length; i++) {
          final tempUser = DataArticles.fromMap(articlesMap1[i]);

          articles.add(tempUser);
        }
      }
    });

    isLoading = false;
    notifyListeners();
    return articles;
  }
}
