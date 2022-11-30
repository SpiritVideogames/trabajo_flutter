import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trabajo_flutter/services/services.dart';
import 'package:trabajo_flutter/services/user_service.dart';

import '../models/models.dart';

class ProductsCompanyServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  final List<DataProducts> products = [];

  bool isLoading = true;

  postProducts() async {
    String? token = await LoginServices().readToken();
    int? id_company = await UserServices().readIdCompany();
    products.clear();
    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, '/public/api/products/company',
        {'company_id': '$id_company'});
    print('hola');
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> productsMap = json.decode(response.body);
    print(productsMap);
    productsMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> productsMap1 = value;
        for (int i = 0; i < productsMap1.length; i++) {
          final tempProduct = DataProducts.fromMap(productsMap1[i]);
          print(tempProduct.compamyName);
          products.add(tempProduct);
        }
      }
    });
    isLoading = false;
    notifyListeners();
    return products;
  }
}
