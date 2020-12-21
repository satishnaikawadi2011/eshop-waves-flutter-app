import 'package:ecommerce_app/providers/order_provider.dart' show Orders;
import 'package:ecommerce_app/widgets/app_drawer.dart';
import 'package:ecommerce_app/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static final String routeName = 'orders_screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
          backgroundColor: Colors.teal,
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemBuilder: (ctx, i) => OrderItem(
            orderItem: orderData.orders[i],
          ),
          itemCount: orderData.orders.length,
        ));
  }
}
