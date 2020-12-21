import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  final String label;
  final String value;
  MyTile({@required this.label, @required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label + " :",
            style: labelTextStyle,
          ),
          Text(
            value,
            style: valueTextStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ],
      ),
    );
  }
}
