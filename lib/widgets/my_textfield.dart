import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final Color color;
  final Function onChanged;
  final bool obscureText;
  final controller;
  MyTextField(
      {this.color = Colors.grey,
      @required this.hintText,
      @required this.icon,
      this.onChanged,
      this.obscureText = false,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        children: [
          Container(
            width: 60.0,
            child: Icon(
              icon,
              size: 30,
              color: color,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
              onChanged: onChanged,
              obscureText: obscureText,
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}
