import 'dart:math';
import 'dart:ui';

import 'package:ecommerce_app/providers/order_provider.dart' as ord;
import 'package:ecommerce_app/widgets/CartItemTile.dart';
import 'package:ecommerce_app/widgets/my_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;
  OrderItem({@required this.orderItem});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          MyTile(
              label: "Total Items",
              value: "${widget.orderItem.products.length}"),
          Divider(
            thickness: 2.0,
          ),
          MyTile(
            label: "Amount",
            value: "\$${widget.orderItem.amount}",
          ),
          Divider(
            thickness: 2.0,
          ),
          MyTile(
              label: "Date and Time",
              value: DateFormat("dd/MM/yy hh:mm")
                  .format(widget.orderItem.dateTime)),
          Divider(
            thickness: 2.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Status :",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Chip(
                    label: widget.orderItem.status
                        ? Text('Delievered')
                        : Text('Pending'),
                    backgroundColor:
                        widget.orderItem.status ? Colors.green : Colors.yellow,
                  ),
                ],
              ),
              IconButton(
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  }),
            ],
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              height: min(widget.orderItem.products.length * 120.0, 200.0),
              child: Column(
                children: [
                  Text(
                    "Order Items",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.orderItem.products.length,
                      itemBuilder: (context, index) => CartItemTile(
                        cartItem: widget.orderItem.products[index],
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
