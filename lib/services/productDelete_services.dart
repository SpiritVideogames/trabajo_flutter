// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

class ProductDeleteServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  ProductDeleteServices();

  deleteProductDelete(String id) async {
    String? token = await LoginServices().readToken();

    final url = Uri.http(_baseUrl, '/public/api/products/$id');
    final response = await http.delete(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> productDelete = json.decode(response.body);

    String resp = '';
    if (productDelete.containsValue(true)) {
    } else {
      String? error = '';

      error = 'Error to delete';

      resp = error;
    }
    return resp;
  }
}
