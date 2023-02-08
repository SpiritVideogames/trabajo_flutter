import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

class OrdersServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';
  final List<DataOrders> orders = [];
  final List<int> numOrders = [];

  bool isLoading = true;

  OrdersServices();

  Future loadOrders() async {
    orders.clear();
    String? token = await LoginServices().readToken();

    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/orders');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> ordersCompanyMap = json.decode(resp.body);

    ordersCompanyMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> ordersCompanyMap1 = value;
        for (int i = 0; i < ordersCompanyMap1.length; i++) {
          final tempOrder = DataOrders.fromMap(ordersCompanyMap1[i]);
          orders.add(tempOrder);
        }
      }
    });

    isLoading = false;
    notifyListeners();
    return orders;
  }

  Future postOrder(int numOrder, DateTime issueDate, int originCompany,
      int targetCompany, String products) async {
    orders.clear();
    String? token = await LoginServices().readToken();

    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/orders', {
      'num': '$numOrder',
      'issue_date': '$issueDate',
      'origin_company_id': '$originCompany',
      'target_company_id': '$targetCompany',
      'products': products,
    });

    final resp = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> productAdd = json.decode(resp.body);

    //print(productAdd);
    if (productAdd.containsValue(true)) {
    } else {}
    return resp;
  }

  Future postOrdersCompany(int idCompany, int idProduct) async {
    numOrders.clear();
    String? token = await LoginServices().readToken();

    numOrders.addAll([0, 0, 0, 0, 0, 0]);

    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/orders/company', {
      'id': '$idCompany',
    });

    final resp = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> ordersCompanyMap = json.decode(resp.body);

    ordersCompanyMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> ordersCompanyMap1 = value;
        for (int i = 0; i < ordersCompanyMap1.length; i++) {
          final tempOrder = DataOrdersCompany.fromMap(ordersCompanyMap1[i]);
          for (int j = 0; j < tempOrder.orderLines.length; j++) {
            for (int k = 0;
                k < tempOrder.orderLines[j].articlesLine.length;
                k++) {
              if (tempOrder.orderLines[j].articlesLine[k].id == idProduct) {
                double months = DateTime.now()
                        .difference(tempOrder.orderLines[j].createdAt)
                        .inDays /
                    30;
                int monthsInt = 0;
                if (months >= 1) {
                  monthsInt = months.round();
                }
                switch (monthsInt) {
                  case 1:
                    numOrders[0] += 1;
                    break;
                  case 2:
                    numOrders[1] += 1;
                    break;
                  case 3:
                    numOrders[2] += 1;
                    break;
                  case 4:
                    numOrders[3] += 1;
                    break;
                  case 5:
                    numOrders[4] += 1;
                    break;
                  case 6:
                    numOrders[5] += 1;
                    break;
                }
              }
            }
          }
        }
      }
    });

    isLoading = false;
    notifyListeners();
    return numOrders;
  }
}
