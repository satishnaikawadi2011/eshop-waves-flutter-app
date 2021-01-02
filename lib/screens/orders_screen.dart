import 'dart:html';

import 'package:ecommerce_app/providers/order_provider.dart' show Orders;
import 'package:ecommerce_app/widgets/app_drawer.dart';
import 'package:ecommerce_app/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static final String routeName = 'orders_screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });
      return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    }).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
          backgroundColor: Colors.teal,
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(
                child: SpinKitFadingCircle(
                  color: Colors.teal,
                ),
              )
            : orderData.orders.length == 0
                ? Center(
                    child: Text("No orders found !!"),
                  )
                : ListView.builder(
                    itemBuilder: (ctx, i) => OrderItem(
                      orderItem: orderData.orders.reversed.toList()[i],
                    ),
                    itemCount: orderData.orders.length,
                  ));
  }
}
