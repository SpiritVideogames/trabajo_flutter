import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

class ProductAddServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  ProductAddServices() {}

  postProductAdd(int article_id, double price, int family_id) async {
    String? token = await LoginServices().readToken();
    int? company_id = await UserServices().readIdCompany();
    print(company_id);
    final url = Uri.http(_baseUrl, '/public/api/products', {
      'article_id': '$article_id',
      'company_id': '$company_id',
      'price': '$price',
      'family_id': '$family_id'
    });
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> productAdd = json.decode(response.body);

    var resp;
    if (productAdd.containsValue(true)) {
      resp = 'hola';
    } else {
      String? error = '';

      error = 'Error to add';

      resp = error;
    }
    print(resp);
    return resp;
  }
}
