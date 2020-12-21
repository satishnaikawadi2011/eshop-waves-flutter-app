import 'package:ecommerce_app/models/category.dart';
import 'package:flutter/material.dart';

class Categories with ChangeNotifier {
  String _active = 'c6';
  List<Category> _categories = [
    Category(
      id: 'c6',
      name: 'All',
    ),
    Category(
      id: 'c1',
      name: 'Men\'s Clothing',
    ),
    Category(
      id: 'c2',
      name: 'Men\'s Footwear',
    ),
    Category(
      id: 'c3',
      name: 'Watches',
    ),
    Category(
      id: 'c4',
      name: 'Mobiles and Accesssories',
    ),
    Category(
      id: 'c5',
      name: 'Bags',
    ),
    Category(
      id: 'c7',
      name: 'Others',
    ),
  ];

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
