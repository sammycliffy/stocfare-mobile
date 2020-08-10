import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/categories.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics.dart';
import 'package:stockfare_mobile/screens/main_pages/home.dart';
import 'package:stockfare_mobile/screens/main_pages/sales_pages/all_sales.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final PageStorageBucket bucket = PageStorageBucket();

  int _currentIndex = 0;
  final List<Widget> _tabs = [
    HomePage(
      key: PageStorageKey('Page1'),
    ),
    CategoryPage(
      key: PageStorageKey('Page2'),
    ),
    AllSalesList(
      key: PageStorageKey('Page3'),
    ),
    AnalyticsPage(
      key: PageStorageKey('Page4'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(
        child: _tabs[_currentIndex],
        bucket: bucket,
      ),
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
