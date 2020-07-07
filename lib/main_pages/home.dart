import 'package:flutter/material.dart';
import 'package:stockfare_mobile/intro_pages/addProducts.dart';
import 'package:stockfare_mobile/intro_pages/add_product_intro.dart';
import 'package:stockfare_mobile/models/user_model.dart';
import 'package:stockfare_mobile/services/auth_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'Electricity',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'Soft Drinks',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'Detergents',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'Fashion',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    color: Colors.black,
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
          ],
        ),
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
