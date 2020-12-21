import 'package:flutter/cupertino.dart';

class Product {
  String id;
  String title;
  int price;
  String description;
  String image;
  String categoryId;

  Product(
      {@required this.id,
      @required this.description,
      @required this.image,
      @required this.price,
      @required this.title,
      @required this.categoryId});
}
