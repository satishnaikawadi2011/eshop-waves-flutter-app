import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Categories>(context, listen: false).fetchAndSetCats();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories = Provider.of<Categories>(context).categories;
    String active = Provider.of<Categories>(context).active;
    Function setActive = Provider.of<Categories>(context).setActive;
    return Container(
      height: 50.0,
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setActive(categories[index].id);
          },
          child: Chip(
            backgroundColor:
                active == categories[index].id ? Colors.teal : Colors.grey[300],
            label: Text(
              categories[index].name,
              style: TextStyle(
                  color: active == categories[index].id
                      ? Colors.white
                      : Colors.black),
            ),
            avatar: CircleAvatar(
              backgroundColor: Colors.pink,
              child: Text(categories[index].name[0]),
            ),
          ),
        ),
        itemCount: categories.length,
      ),
    );
  }
}
