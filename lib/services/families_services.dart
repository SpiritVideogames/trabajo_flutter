import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trabajo_flutter/models/user.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

class FamiliesServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';
  final List<DataFamilies> families = [];

  bool isLoading = true;

  FamiliesServices() {}

  Future loadFamilies() async {
    families.clear();

    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/families');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
    });

    final Map<String, dynamic> familiesMap = json.decode(resp.body);

    familiesMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> familiesMap1 = value;
        for (int i = 0; i < familiesMap1.length; i++) {
          final tempFamily = DataFamilies.fromMap(familiesMap1[i]);
          families.add(tempFamily);
        }
      }
    });

    isLoading = false;
    notifyListeners();
    return families;
  }
}
