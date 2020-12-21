import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final String productId;
  CartItemTile({@required this.cartItem, this.productId});
  @override
  Widget build(BuildContext context) {
    final price = cartItem.price;
    final qty = cartItem.quantity;
    final subTotal = price * qty;
    return productId != null
        ? Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              child: Icon(
                Icons.delete,
                size: 40.0,
                color: Colors.white,
              ),
              color: Colors.red,
              padding: EdgeInsets.only(right: 15.0),
              margin: EdgeInsets.only(bottom: 10.0),
              alignment: Alignment.centerRight,
            ),
            onDismissed: (direction) {
              final cart = Provider.of<Cart>(context, listen: false);
              cart.removeItem(productId);
            },
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.network(cartItem.image),
                ),
                title: Text(cartItem.title),
                subtitle: Text("$qty x \$$price"),
                trailing: Text("\$$subTotal"),
              ),
            ),
          )
        : Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(cartItem.image),
              ),
              title: Text(cartItem.title),
              subtitle: Text("$qty x \$$price"),
              trailing: Text("\$$subTotal"),
            ),
          );
  }
}
