// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trabajo_flutter/services/services.dart';

import '../models/models.dart';

class ProductsCompanyServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  final List<DataProductsCompany> productsCompany = [];
  final List<DataProductsCompany> productsUser = [];
  final List<DataProductsCompany> aux = [];

  bool isLoading = true;

  postProductsCompany() async {
    String? token = await LoginServices().readToken();
    int? idCompany = await UserServices().readIdCompany();

    isLoading = true;
    notifyListeners();

    final url = Uri.http(
        _baseUrl, '/public/api/products/company', {'id': '$idCompany'});

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

  getMyProducts() async {
    String? token = await LoginServices().readToken();
    int? idCompany = await UserServices().readIdCompany();

    isLoading = true;
    notifyListeners();

    final url = Uri.http(
        _baseUrl, '/public/api/products/company', {'id': '$idCompany'});

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

          productsUser.add(tempProduct);
        }
      }
    });
    isLoading = false;
    notifyListeners();

    return productsUser;
  }

  getProducts(int? id) async {
    String? token = await LoginServices().readToken();
    int? idCompany = id;
    getMyProducts();
    isLoading = true;
    notifyListeners();

    final url = Uri.http(
        _baseUrl, '/public/api/products/company', {'id': '$idCompany'});

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
          /*  for (DataProductsCompany e in productsCompany) {
            print(e.compamyName);
          }
          for (DataProductsCompany e in productsUser) {
            print(e.compamyName);
          }*/

        }
      }
    });
    for (int i = 0; i < productsUser.length; i++) {
      for (int j = 0; j < productsCompany.length; j++) {
        if (productsCompany[j].articleId == productsUser[i].articleId) {
          aux.add(productsCompany[j]);
        }
      }
    }
    for (int i = 0; i < aux.length; i++) {}
    isLoading = false;
    notifyListeners();

    return aux;
  }
}
