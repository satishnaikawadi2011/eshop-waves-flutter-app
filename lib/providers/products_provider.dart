import 'package:ecommerce_app/models/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../models//product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String authToken;
  List<Product> _items;
  Products(this.authToken, this._items);
  Future<void> fetchAndSetProducts() async {
    try {
      final url = "https://eshopadminapp.herokuapp.com/api/product";
      Map<String, String> headers = {'Authorization': 'Bearer $authToken'};
      final response = await http.get(url, headers: headers);
      final extractedData = json.decode(response.body);
      if (extractedData is List<dynamic>) {
        final List<Product> loadedProducts = [];
        extractedData.forEach((prod) {
          loadedProducts.add(Product(
              id: prod['_id'],
              description: prod['description'],
              image: 'https://eshopadminapp.herokuapp.com${prod['image']}',
              price: prod['price'],
              title: prod['title'],
              categoryId: prod['categoryId']));
        });
        _items = loadedProducts;
        notifyListeners();
      } else {
        throw HttpException(extractedData['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  List<Product> get items {
    return [..._items];
  }
}
