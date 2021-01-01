import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/products_provider.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/widgets/app_drawer.dart';
import 'package:ecommerce_app/widgets/category_list.dart';
import 'package:ecommerce_app/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProductOverviewScreen extends StatefulWidget {
  static final String routename = '/';
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "EShop Waves",
          style: TextStyle(fontFamily: 'Ubuntu'),
        ),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              badgeContent: Text(
                cart.itemCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                child: Icon(
                  Icons.shopping_cart,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 70.0,
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: SpinKitFadingCircle(
                color: Colors.teal,
              ),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: CategoryList(),
                ),
                Expanded(
                  flex: 10,
                  child: ProductsGrid(),
                ),
              ],
            ),
    );
  }
}
