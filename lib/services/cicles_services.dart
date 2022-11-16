import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class CiclesServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  final List<DataCicles> cicles = [];
  bool isLoading = true;

  CiclesServices() {
    getCicles();
  }

  getCicles() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      '/public/api/cicles',
    );
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
    });

    final Map<String, dynamic> ciclesMap = json.decode(response.body);

    ciclesMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> ciclesMap1 = value;
        for (int i = 0; i < ciclesMap1.length; i++) {
          final tempCicle = DataCicles.fromMap(ciclesMap1[i]);

          cicles.add(tempCicle);
        }
      }
    });
    isLoading = false;
    notifyListeners();
    return cicles;
  }
}
