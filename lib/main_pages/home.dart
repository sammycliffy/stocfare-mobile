import 'package:flutter/material.dart';
import 'package:stockfare_mobile/intro_pages/addProducts.dart';
import 'package:stockfare_mobile/main_pages/all_products_list/available.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 100.0,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Electricity',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 100.0,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Soft Drinks',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 100.0,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Detergents',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 100.0,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Fashion',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 100.0,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Electricity',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 5, left: 250),
            child: Stack(
              children: [
                Icon(Icons.shopping_cart, size: 30, color: Colors.red),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Container(
                    width: 40,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red),
                    child: Center(
                      child: Text(
                        '1234',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: ProductsAvailable())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
