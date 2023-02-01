import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'services.dart';

class CompaniesServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';

  final List<DataCompanies> companies = [];
  bool isLoading = true;

  CompaniesServices() {
    getCompanies();
  }

  getCompanies() async {
    isLoading = true;
    int? idUserCompany = await UserServices().readIdCompany();
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/companies');
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
    });

    final Map<String, dynamic> companiesMap = json.decode(response.body);

    companiesMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> companiesMap1 = value;
        for (int i = 0; i < companiesMap1.length; i++) {
          final tempCompany = DataCompanies.fromMap(companiesMap1[i]);
          if (tempCompany.id == idUserCompany) {
          } else {
            companies.add(tempCompany);
          }
        }
      }
    });
    isLoading = false;
    notifyListeners();
    return companies;
  }
}
