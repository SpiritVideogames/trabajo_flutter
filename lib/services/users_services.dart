import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

class UsersServices extends ChangeNotifier {
  final String _baseUrl = 'salesin.allsites.es';

  final List<Datum3> users = [];
  bool isLoading = true;

  UsersServices() {
    loadUsers();
  }

  Future loadUsers() async {
    String token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiZWEyZGI3Nzg3NzlmYzE3NTAzOTY3OTFjZDgyZDNkZjJjN2NkNGFhNTRkOTM4ODJiZWFjMTY2MzI4YzYyMzliOTg0YzFhYjU5YzNjYmUyMjQiLCJpYXQiOjE2NjczNzQ1NTgsIm5iZiI6MTY2NzM3NDU1OCwiZXhwIjoxNjk4OTEwNTU4LCJzdWIiOiI5OSIsInNjb3BlcyI6W119.uL_1gMspDDI7NL-xZ81BVlf3bVab2n29gQQfYS1iIA7O1b_G4KUDigRB90vIJfhQjqFQNX2bGap9GJS_NaPc06gMbwffh-3-LJqgt6JF5eEXmvvZXpHM-koV4J57-H5wXhK6OpSEiJjLEMQncjtMBmNtiTHJL1-GZb9fNEEBKlyEXq8tK46vYH4mw6YifHjhtBj_1ZJkTQlYLvtXpHcx_C-Vb_zrtpRKRX-OpoOimw5EACFsbfPC5Vp7MKEtcSqNagPiaSS48gdJeH6pGeGsJHbeGAlsh1aFgw5R4mxeGmKgxswqpCENu8OqmqUtnMBH2Ndco6V_-j1YgHJvJfZ-a6xx8B_hH0JK8Z70wWaa6WikdVEjpf7sz2nzGdQ4DqYfK9pXqqZCdFu35xX5SQnniGjpehlvphkhnrRjB3_dmsftwAI6l54AGog0YgZGITq5xNfLbVYYGMlY8l9iL-cZj0SoSwnaWVK-u5QFgTG0DYruCvtVVu0RUKNIWdY2wB6IR094iMCU3FWrK_NSIVuJKfP_cm8gvWISG_Z3kv_ajlSBWICFEFbkO4-mka5wVafTZA2oFE5Ek3RwVHDi5asYqe7PgYd9VMe2hex6IBuGD62smhi3Jz4YNOf-hW6BWRNPrz3SNZC8TuKVhpjeeYo8Ns6aSsjpUSKQ5iofdf22uAE';
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/users');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> usersMap = json.decode(resp.body);

    usersMap.forEach((key, value) {
      if (key == "data") {
        for (int i = 0; i < value.length; i++) {
          final tempUser = Datum3.fromMap(value[i]);

          this.users.add(tempUser);
        }
      }
    });

    isLoading = false;
    notifyListeners();
    return users;
  }
}
