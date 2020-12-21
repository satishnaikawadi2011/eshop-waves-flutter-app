import 'package:ecommerce_app/models/cart_item.dart';
import 'package:flutter/material.dart';

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

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, int total) {
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: DateTime.now(),
            id: DateTime.now().toString(),
            products: cartProducts));
  }
}
