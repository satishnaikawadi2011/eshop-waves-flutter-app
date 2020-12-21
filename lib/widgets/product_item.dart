import 'package:ecommerce_app/screens/product_detail.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final int price;
  final String image;

  ProductItem(
      {@required this.id,
      @required this.image,
      @required this.price,
      @required this.title});
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.routename, arguments: id);
        },
        child: Hero(
          tag: id,
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
      footer: Container(
        padding: EdgeInsets.only(left: 5.0),
        color: Color.fromRGBO(0, 0, 0, 0.7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "\$" + price.toString(),
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
