import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String userId;

  Future<void> register(String username, String email, String password) async {
    const url = "http://localhost:5000/api/user/register";
    final response = await http.post(url,
        body: json.encode(
            {'email': email, 'password': password, 'username': username}));
    print(json.decode(response.body));
  }
}
