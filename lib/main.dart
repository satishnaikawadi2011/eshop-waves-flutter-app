import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/category_provider.dart';
import 'package:ecommerce_app/providers/order_provider.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/orders_screen.dart';
import 'package:ecommerce_app/screens/product_detail.dart';
import 'package:ecommerce_app/screens/splash_screen.dart';
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
    return MediaQuery(
        data: MediaQueryData(),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: Auth(),
            ),
            ChangeNotifierProxyProvider<Auth, Products>(
              update: (ctx, auth, prevProducts) => Products(
                  auth.token, prevProducts == null ? [] : prevProducts.items),
            ),
            ChangeNotifierProvider.value(
              value: Categories(),
            ),
            ChangeNotifierProvider.value(
              value: Cart(),
            ),
            ChangeNotifierProxyProvider<Auth, Orders>(
              update: (ctx, auth, prevOrders) => Orders(
                  auth.token, prevOrders == null ? [] : prevOrders.orders),
            ),
          ],
          child: SafeArea(
            child: Consumer<Auth>(
              builder: (ctx, auth, _) => MaterialApp(
                title: 'EShop Waves',
                theme: ThemeData(
                  fontFamily: 'Ubuntu',
                ),
                home: auth.isAuth
                    ? ProductOverviewScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authSnapShot) =>
                            authSnapShot.connectionState ==
                                    ConnectionState.waiting
                                ? SplashScreen()
                                : LoginScreen(),
                      ),
                routes: {
                  ProductDetailScreen.routename: (context) =>
                      ProductDetailScreen(),
                  CartScreen.routeName: (context) => CartScreen(),
                  OrdersScreen.routeName: (context) => OrdersScreen(),
                },
              ),
            ),
          ),
        ));
  }
}
