import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trabajo_flutter/models/user.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

class OrdersServices extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';
  final List<DataOrders> orders = [];

  bool isLoading = true;

  OrdersServices() {}

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

    final Map<String, dynamic> ordersMap = json.decode(resp.body);

    ordersMap.forEach((key, value) {
      if (key == "data") {
        final List<dynamic> ordersMap1 = value;
        for (int i = 0; i < ordersMap1.length; i++) {
          final tempOrder = DataOrders.fromMap(ordersMap1[i]);
          orders.add(tempOrder);
        }
      }
    });

    isLoading = false;
    notifyListeners();
    return orders;
  }
}
