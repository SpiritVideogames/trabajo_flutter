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
  final List<DateTime> months = [];

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

    print(resp.body);

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
              if (tempOrder.orderLines[j].articlesLine[k].articleCompany.id ==
                  idProduct) {
                DateTime now = DateTime.now();
                DateTime hace1Mes = DateTime(now.year, now.month - 1, now.day);
                DateTime hace2Mes = DateTime(now.year, now.month - 2, now.day);
                DateTime hace3Mes = DateTime(now.year, now.month - 3, now.day);
                DateTime hace4Mes = DateTime(now.year, now.month - 4, now.day);
                DateTime hace5Mes = DateTime(now.year, now.month - 5, now.day);
                DateTime hace6Mes = DateTime(now.year, now.month - 6, now.day);

                months.add(hace1Mes);
                months.add(hace2Mes);
                months.add(hace3Mes);
                months.add(hace4Mes);
                months.add(hace5Mes);
                months.add(hace6Mes);

                DateTime monthsProduct = tempOrder.issueDate;

                if (hace1Mes.year == monthsProduct.year &&
                    hace1Mes.month == monthsProduct.month) {
                  numOrders[0] += 1;
                } else if (hace2Mes.year == monthsProduct.year &&
                    hace2Mes.month == monthsProduct.month) {
                  numOrders[1] += 1;
                } else if (hace3Mes.year == monthsProduct.year &&
                    hace3Mes.month == monthsProduct.month) {
                  numOrders[2] += 1;
                } else if (hace4Mes.year == monthsProduct.year &&
                    hace4Mes.month == monthsProduct.month) {
                  numOrders[3] += 1;
                } else if (hace5Mes.year == monthsProduct.year &&
                    hace5Mes.month == monthsProduct.month) {
                  numOrders[4] += 1;
                } else if (hace6Mes.year == monthsProduct.year &&
                    hace6Mes.month == monthsProduct.month) {
                  numOrders[5] += 1;
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
