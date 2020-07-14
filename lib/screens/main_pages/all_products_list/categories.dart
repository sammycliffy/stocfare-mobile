import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/products_list.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
        drawer: DrawerPage(),
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Category List')),
        body: GridView.count(
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 3,
          children: List.generate(10, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Electricity',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        '125 Items',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Container(
                          width: 80,
                          decoration: BoxDecoration(color: Colors.black),
                          child: Center(
                              child: Text(
                            'View',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllProductsList()));
                },
              ),
            );
          }),
        ));
  }
}
