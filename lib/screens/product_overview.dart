import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/widgets/app_drawer.dart';
import 'package:ecommerce_app/widgets/category_list.dart';
import 'package:ecommerce_app/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

class ProductOverviewScreen extends StatelessWidget {
  static final String routename = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "EShop Waves",
          style: TextStyle(fontFamily: 'Ubuntu'),
        ),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              badgeContent: Text(
                cart.itemCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                child: Icon(
                  Icons.shopping_cart,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 70.0,
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CategoryList(),
          ),
          Expanded(
            flex: 10,
            child: ProductsGrid(),
          ),
        ],
      ),
    );
  }
}
