import 'dart:async';
import 'package:ecommerce_app/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

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
        autoLogout();
        notifyListeners();
        storeDataToSharedPrefs();
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
        autoLogout();
        notifyListeners();
        storeDataToSharedPrefs();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    print("Expiry Date : $expiryDate");
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  void storeDataToSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String()
    });
    prefs.setString('userData', userData);
  }
}
