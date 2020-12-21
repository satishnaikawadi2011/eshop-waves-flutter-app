import 'package:ecommerce_app/models/cart_item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, String title, int price, String image) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
              image: image,
              id: value.id,
              price: value.price,
              quantity: value.quantity + 1,
              title: value.title));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                image: image,
                id: DateTime.now().toString(),
                price: price,
                title: title,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeItem(productId) {
    _items.remove(productId);
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  int get totalItems {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
