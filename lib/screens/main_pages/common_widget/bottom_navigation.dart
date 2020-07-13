import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/categories.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/products_list.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics.dart';
import 'package:stockfare_mobile/screens/main_pages/home.dart';
import 'package:stockfare_mobile/screens/main_pages/online_store.dart';
import 'package:stockfare_mobile/screens/main_pages/sales_pages/all_sales.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;
  List<Widget> _tabs = [
    HomeScreen(),
    CategoryPage(),
    AllSalesList(),
    AnalyticsPage(),
    OnlineStore()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2.0,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Hexcolor('#c80815'),
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Hexcolor('#c80815'),
              ),
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_giftcard,
              color: Hexcolor('#c80815'),
            ),
            title: Text(
              'Products',
              style: TextStyle(
                color: Hexcolor('#c80815'),
              ),
            ),
            backgroundColor: Colors.deepOrange,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monetization_on,
              color: Hexcolor('#c80815'),
            ),
            title: Text(
              'Sales',
              style: TextStyle(
                color: Hexcolor('#c80815'),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.multiline_chart,
              color: Hexcolor('#c80815'),
            ),
            title: Text(
              'Analytics',
              style: TextStyle(
                color: Hexcolor('#c80815'),
              ),
            ),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Hexcolor('#c80815'),
            ),
            title: Text(
              'Shop',
              style: TextStyle(
                color: Hexcolor('#c80815'),
              ),
            ),
            backgroundColor: Colors.green,
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
