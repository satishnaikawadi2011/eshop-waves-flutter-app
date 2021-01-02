import 'package:ecommerce_app/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, dynamic> _encodableItems = {};
  Future<void> getDataFromPrefs() async {
    print("Inside prefs");
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('cartData')) {
      print("Here no cart");
      _items = {};
      return;
    }
    final data = prefs.getString('cartData');
    final cartData = json.decode(data) as Map<String, dynamic>;
    final Map<String, CartItem> convertedCartData = {};
    cartData.forEach((key, value) {
      convertedCartData[key] = CartItem(
          id: value['id'],
          price: value['price'],
          quantity: value['quantity'],
          title: value['title'],
          image: value['image']);
    });
    _items = convertedCartData;
    notifyListeners();
    print(_items);
    return;
  }

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, String title, int price, String image) async {
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
                id: productId,
                price: price,
                title: title,
                quantity: 1,
              ));
    }
    notifyListeners();
    convertToEncodable();
    final prefs = await SharedPreferences.getInstance();
    final cartData = json.encode(_encodableItems);
    prefs.setString('cartData', cartData);
  }

  void removeItem(productId) async {
    _items.remove(productId);
    notifyListeners();
    convertToEncodable();
    final prefs = await SharedPreferences.getInstance();
    final cartData = json.encode(_encodableItems);
    prefs.setString('cartData', cartData);
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

  void clearCart() async {
    _items = {};
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final cartData = json.encode({});
    prefs.setString('cartData', cartData);
  }

  void convertToEncodable() {
    _items.forEach((key, value) {
      _encodableItems[key] = {
        'id': value.id,
        'title': value.title,
        'price': value.price,
        'quantity': value.quantity,
        'image': value.image
      };
    });
  }
}
