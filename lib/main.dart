import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/category_provider.dart';
import 'package:ecommerce_app/providers/order_provider.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/orders_screen.dart';
import 'package:ecommerce_app/screens/product_detail.dart';
import 'package:flutter/material.dart';

import './screens//product_overview.dart';
import 'package:provider/provider.dart';
import './providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MediaQuery(
        data: MediaQueryData(),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: Products(),
            ),
            ChangeNotifierProvider.value(
              value: Categories(),
            ),
            ChangeNotifierProvider.value(
              value: Cart(),
            ),
            ChangeNotifierProvider.value(
              value: Orders(),
            ),
            ChangeNotifierProvider.value(
              value: Auth(),
            )
          ],
          child: SafeArea(
            child: MaterialApp(
              title: 'EShop Waves',
              theme: ThemeData(
                fontFamily: 'Ubuntu',
              ),
              routes: {
                ProductDetailScreen.routename: (context) =>
                    ProductDetailScreen(),
                // ProductOverviewScreen.routename: (context) =>
                //     ProductOverviewScreen(),
                '/': (context) => LoginScreen(),
                CartScreen.routeName: (context) => CartScreen(),
                OrdersScreen.routeName: (context) => OrdersScreen(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
