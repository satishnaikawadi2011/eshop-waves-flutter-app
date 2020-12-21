import 'package:ecommerce_app/screens/orders_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.teal,
            title: Text("EShop Waves"),
            automaticallyImplyLeading: false,
          ),
          Divider(
            thickness: 2.5,
          ),
          ListTile(
            leading: Icon(
              Icons.shop,
              color: Colors.teal,
            ),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(
            thickness: 2.5,
          ),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Colors.teal,
            ),
            title: Text("Orders"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(
            thickness: 2.5,
          ),
        ],
      ),
    );
  }
}
