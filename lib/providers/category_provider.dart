import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class Categories with ChangeNotifier {
  final String authToken;
  String _active = 'c6';
  List<Category> _categories;
  Categories(this.authToken, this._categories);

  Future<void> fetchAndSetCats() async {
    try {
      final url = "https://eshopadminapp.herokuapp.com/api/category";
      Map<String, String> headers = {'Authorization': 'Bearer $authToken'};
      final response = await http.get(url, headers: headers);
      final extractedData = json.decode(response.body);
      if (extractedData is List<dynamic>) {
        final List<Category> loadedCats = [
          Category(
            id: 'c6',
            name: 'All',
          ),
        ];
        extractedData.forEach((cat) {
          loadedCats.add(Category(id: cat['_id'], name: cat['name']));
        });
        _categories = loadedCats;
        notifyListeners();
      } else {
        throw HttpException(extractedData['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  List<Category> get categories {
    return [..._categories];
  }

  String get active {
    return _active;
  }

  void setActive(String id) {
    _active = id;
    notifyListeners();
  }
}
