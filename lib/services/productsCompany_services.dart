import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trabajo_flutter/services/services.dart';
import 'package:trabajo_flutter/services/user_service.dart';

import '../models/models.dart';

class ProductsCompanyServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  final List<DataProductsCompany> productsCompany = [];

  bool isLoading = true;

  postProductsCompany() async {
    String? token = await LoginServices().readToken();
    int? id_company = await UserServices().readIdCompany();
    productsCompany.clear();
    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, '/public/api/products/company',
        {'company_id': '$id_company'});
    print('hola');
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> productsCompanyMap = json.decode(response.body);

    productsCompanyMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> productsCompanyMap1 = value;
        for (int i = 0; i < productsCompanyMap1.length; i++) {
          final tempProduct =
              DataProductsCompany.fromMap(productsCompanyMap1[i]);

          productsCompany.add(tempProduct);
        }
      }
    });
    isLoading = false;
    notifyListeners();
    return productsCompany;
  }
}
