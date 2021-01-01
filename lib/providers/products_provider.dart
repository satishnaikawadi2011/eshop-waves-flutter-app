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
      // print(authToken);
      final url = "https://eshopadminapp.herokuapp.com/api/product";
      Map<String, String> headers = {'Authorization': 'Bearer $authToken'};
      final response = await http.get(url, headers: headers);
      final extractedData = json.decode(response.body);
      if (extractedData is List<dynamic>) {
        print(extractedData);
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
        // print("here");
      } else {
        throw HttpException(extractedData['message']);
      }
    } catch (e) {
      throw e;
    }
  }
  //  = [
  //   Product(
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel neque nec magna consectetur dictum. Suspendisse sed ullamcorper urna. Vivamus.',
  //       id: 'p1',
  //       image:
  //           'https://cdn.pixabay.com/photo/2017/01/13/04/56/blank-1976334__340.png',
  //       price: 100,
  //       title: 'White T-Shirt',
  //       categoryId: 'c1'),
  //   Product(
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel neque nec magna consectetur dictum. Suspendisse sed ullamcorper urna. Vivamus.',
  //       id: 'p2',
  //       image:
  //           'https://images.unsplash.com/photo-1497339100210-9e87df79c218?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8c2hpcnR8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  //       price: 500,
  //       title: 'Formal Shirt',
  //       categoryId: 'c1'),
  //   Product(
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel neque nec magna consectetur dictum. Suspendisse sed ullamcorper urna. Vivamus.',
  //       id: 'p3',
  //       image:
  //           'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvZXN8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  //       price: 200,
  //       title: 'Nike White Shoes',
  //       categoryId: 'c2'),
  //   Product(
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel neque nec magna consectetur dictum. Suspendisse sed ullamcorper urna. Vivamus.',
  //       id: 'p4',
  //       image:
  //           'https://images.unsplash.com/photo-1597946650068-3be3408e6299?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTJ8fGVjb21tZXJjZSUyMHByb2R1Y3RzfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  //       price: 1000,
  //       title: 'Bouncy Bags Collection',
  //       categoryId: 'c5'),
  //   Product(
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel neque nec magna consectetur dictum. Suspendisse sed ullamcorper urna. Vivamus.',
  //       id: 'p5',
  //       image:
  //           'https://images.unsplash.com/photo-1589492477829-5e65395b66cc?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTl8fG1vYmlsZXN8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  //       price: 10000,
  //       title: 'Black Iphone 11 Pro',
  //       categoryId: 'c4'),
  //   Product(
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel neque nec magna consectetur dictum. Suspendisse sed ullamcorper urna. Vivamus.',
  //       id: 'p6',
  //       image:
  //           'https://images.unsplash.com/photo-1562157873-818bc0726f68?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Nzl8fGxhZGllcyUyMHdlYXJ8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  //       price: 600,
  //       title: 'Smothy Collection',
  //       categoryId: 'c1'),
  //   Product(
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel neque nec magna consectetur dictum. Suspendisse sed ullamcorper urna. Vivamus.',
  //       id: 'p7',
  //       image:
  //           'https://cdn.pixabay.com/photo/2015/09/26/09/08/hipster-958805_1280.jpg',
  //       price: 300,
  //       title: 'Blue Stylish Sneakers',
  //       categoryId: 'c2'),
  //   Product(
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel neque nec magna consectetur dictum. Suspendisse sed ullamcorper urna. Vivamus.',
  //       id: 'p8',
  //       image:
  //           'https://cdn.pixabay.com/photo/2015/09/26/09/09/hipster-958806__340.jpg',
  //       price: 5000,
  //       title: 'Rollex Watch',
  //       categoryId: 'c3'),
  // ];

  List<Product> get items {
    return [..._items];
  }

  void addProduct() {
    // _items.add(value)
    notifyListeners();
  }
}
