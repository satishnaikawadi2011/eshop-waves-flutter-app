import 'package:ecommerce_app/providers/category_provider.dart';
import 'package:ecommerce_app/providers/products_provider.dart';
import 'package:ecommerce_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import '../models//product.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final active = Provider.of<Categories>(context).active;
    var loadedProducts = productsData.items;
    if (active != 'c6') {
      loadedProducts = loadedProducts
          .where((element) => element.categoryId == active)
          .toList();
    }
    return loadedProducts.length == 0
        ? Center(
            child: Text("No Products Found !!"),
          )
        : GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.0),
            itemCount: loadedProducts.length,
            itemBuilder: (context, i) => ProductItem(
              id: loadedProducts[i].id,
              image: loadedProducts[i].image,
              title: loadedProducts[i].title,
              price: loadedProducts[i].price,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
          );
  }
}
