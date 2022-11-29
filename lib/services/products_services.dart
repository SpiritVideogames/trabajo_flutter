import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class ProductsServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  final List<DataProducts> products = [];
  bool isLoading = true;

  ProductsServices() {
    postProducts();
  }

  postProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/products');
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
    });

    final Map<String, dynamic> productsMap = json.decode(response.body);

    productsMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> productsMap1 = value;
        for (int i = 0; i < productsMap1.length; i++) {
          final tempProduct = DataProducts.fromMap(productsMap1[i]);

          products.add(tempProduct);
        }
      }
    });
    isLoading = false;
    notifyListeners();
    return products;
  }
}
