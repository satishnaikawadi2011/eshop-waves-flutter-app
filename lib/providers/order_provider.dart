import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final int amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final bool status;
  OrderItem(
      {@required this.amount,
      @required this.dateTime,
      @required this.id,
      @required this.products,
      this.status = false});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;

  Orders(this.authToken, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    try {
      final url = "https://eshopadminapp.herokuapp.com/api/order";
      Map<String, String> headers = {'Authorization': 'Bearer $authToken'};
      final response = await http.get(url, headers: headers);
      final extractedData = json.decode(response.body);
      if (extractedData is List<dynamic>) {
        print(extractedData);
        final List<OrderItem> loadedProducts = [];
        // extractedData.forEach((prod) {
        //   loadedProducts.add(Product(
        //       id: prod['_id'],
        //       description: prod['description'],
        //       image: 'https://eshopadminapp.herokuapp.com${prod['image']}',
        //       price: prod['price'],
        //       title: prod['title'],
        //       categoryId: prod['categoryId']));
        // });
        // _items = loadedProducts;
        notifyListeners();
        // print("here");
      } else {
        throw HttpException(extractedData['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  void addOrder(List<CartItem> cartProducts, int total) async {
    // final url = 'https://eshopadminapp.herokuapp.com/api/order/add';
    // Map<String, String> headers = {'Authorization': 'Bearer $authToken'};
    // final response = await http.post(url, headers: headers);
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: DateTime.now(),
            id: DateTime.now().toString(),
            products: cartProducts));
  }
}
