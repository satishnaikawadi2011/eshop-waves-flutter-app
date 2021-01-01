import 'package:ecommerce_app/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    print(_expiryDate);
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> register(String username, String email, String password) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      const url = "https://eshopadminapp.herokuapp.com/api/user/register";
      final response = await http.post(url,
          headers: headers,
          body: json.encode(
              {'email': email, 'password': password, 'username': username}));
      final res = json.decode(response.body);
      if (res['message'] != null) {
        throw HttpException(res['message']);
      } else {
        print(res);
        final tokenIn = res['token'];
        Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenIn);
        _token = tokenIn;
        _userId = decodedToken['id'];
        _expiryDate =
            DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> login(String username, String password) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      const url = "https://eshopadminapp.herokuapp.com/api/user/login";
      final response = await http.post(url,
          headers: headers,
          body: json.encode({'password': password, 'username': username}));
      final res = json.decode(response.body);
      if (res['message'] != null) {
        throw HttpException(res['message']);
      } else {
        print(res);
        final tokenIn = res['token'];
        Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenIn);
        _token = tokenIn;
        _userId = decodedToken['id'];
        _expiryDate =
            DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }
}
