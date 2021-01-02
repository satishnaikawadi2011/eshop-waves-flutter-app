import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/order_provider.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/widgets/CartItemTile.dart';
import 'package:ecommerce_app/widgets/my_rounded_button.dart';
import 'package:ecommerce_app/widgets/my_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String routeName = 'cart_screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Cart>(context, listen: false).getDataFromPrefs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    bool isCartEmpty = cart.items.length == 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 5.0,
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                MyTile(
                    label: "Total Items ", value: cart.totalItems.toString()),
                Divider(
                  thickness: 2.0,
                ),
                MyTile(
                    label: "Total Price ",
                    value: "\$" + cart.totalAmount.toString()),
                Divider(
                  thickness: 2.0,
                ),
                MyRoundedButton(
                  color: Colors.pink[300],
                  label: "CHECKOUT",
                  onPress: () {
                    checkoutOrder(context, cart);
                  },
                  disabled: isCartEmpty,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Cart Items",
            textAlign: TextAlign.center,
            style: valueTextStyle,
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CartItemTile(
                cartItem: cart.items.values.toList()[index],
                productId: cart.items.keys.toList()[index],
              ),
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }

  void checkoutOrder(BuildContext context, Cart cart) {
    var alertDialog = AlertDialog(
      title: Text("CHEKOUT ORDER"),
      titleTextStyle: TextStyle(
        color: Colors.teal,
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.w700,
        fontSize: 25.0,
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Provider.of<Orders>(context, listen: false)
                .addOrder(cart.items.values.toList(), cart.totalAmount);
            cart.clearCart();
            Navigator.of(context).pop();
          },
          child: Text(
            "Confirm",
            style: TextStyle(
                color: Colors.teal,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w600),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(
                color: Colors.pink,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w600),
          ),
        )
      ],
      content: Text("Are you sure , you want to checkout these products ?"),
    );

    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
}
