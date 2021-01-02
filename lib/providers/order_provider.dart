import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

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
      final url = "https://eshopadminapp.herokuapp.com/api/order/me";
      Map<String, String> headers = {'Authorization': 'Bearer $authToken'};
      final response = await http.get(url, headers: headers);
      final extractedData = json.decode(response.body);
      if (extractedData is List<dynamic>) {
        final List<OrderItem> loadedOrders = [];
        extractedData.forEach((order) {
          final List<CartItem> convertedProducts = [];
          order['orderItems'].forEach((item) {
            convertedProducts.add(CartItem(
                id: item['productId'],
                image: 'https://eshopadminapp.herokuapp.com${item['image']}',
                price: item['price'],
                title: item['title'],
                quantity: item['qty']));
          });
          loadedOrders.add(OrderItem(
              amount: order['amount'],
              dateTime: DateTime.parse(order['createdAt']),
              id: order['_id'],
              products: convertedProducts,
              status: order['status']));
        });
        _orders = loadedOrders;
        notifyListeners();
      } else {
        throw HttpException(extractedData['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, int total) async {
    final url = 'https://eshopadminapp.herokuapp.com/api/order/add';
    Map<String, String> headers = {
      'Authorization': 'Bearer $authToken',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final convertedCartProds = [];
    cartProducts.forEach((element) {
      convertedCartProds.add({
        'price': element.price,
        'productId': element.id,
        'title': element.title,
        'image': element.image.split(".com")[1],
        'qty': element.quantity
      });
    });
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    final Map<String, dynamic> body = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'amount': total,
      'orderItems': [...convertedCartProds]
    };
    final response =
        await http.post(url, body: json.encode(body), headers: headers);
    final res = json.decode(response.body);
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: DateTime.parse(res['createdAt']),
            id: res['_id'],
            products: cartProducts));
  }
}
