import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/widgets/my_rounded_button.dart';
import 'package:ecommerce_app/widgets/my_tile.dart';

import 'package:ecommerce_app/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final snackBar = SnackBar(
      content: Text(
    'Item added to cart!!!',
  ));
  static final String routename = 'product_detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context)
        .items
        .firstWhere((element) => element.id == productId);
    Function addToCart = Provider.of<Cart>(context).addItem;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct.title,
          style: TextStyle(fontFamily: 'Ubuntu'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.image,
                  fit: BoxFit.cover,
                  height: 300.0,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MyTile(
                  label: "Price", value: "\$" + loadedProduct.price.toString()),
              Divider(
                color: Colors.grey,
              ),
              MyTile(label: "Title", value: loadedProduct.title),
              Divider(
                color: Colors.grey,
              ),
              Text(
                "Description",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Ubuntu',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  loadedProduct.description,
                  style: TextStyle(color: Colors.grey[500], fontSize: 20.0),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MyRoundedButton(
                label: "ADD TO CART",
                color: Colors.pink[300],
                onPress: () {
                  addToCart(productId, loadedProduct.title, loadedProduct.price,
                      loadedProduct.image);
                  Scaffold.of(context).showSnackBar(snackBar);
                },
                disabled: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
