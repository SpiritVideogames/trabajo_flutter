// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

class ProductAddServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  ProductAddServices();

  postProductAdd(int articleId, double price, int familyId) async {
    String? token = await LoginServices().readToken();
    int? companyId = await UserServices().readIdCompany();
    final url = Uri.http(_baseUrl, '/public/api/products', {
      'article_id': '$articleId',
      'company_id': '$companyId',
      'price': '$price',
      'family_id': '$familyId'
    });
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> productAdd = json.decode(response.body);

    String resp;
    if (productAdd.containsValue(true)) {
      resp = 'hola';
    } else {
      String? error = '';

      error = 'Error to add';

      resp = error;
    }
    return resp;
  }
}
