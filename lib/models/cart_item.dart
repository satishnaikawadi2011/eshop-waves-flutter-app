import 'package:flutter/cupertino.dart';

class CartItem {
  String id;
  String title;
  int price;
  int quantity;
  String image;

  CartItem(
      {@required this.id,
      @required this.price,
      @required this.quantity,
      @required this.title,
      @required this.image});
}
