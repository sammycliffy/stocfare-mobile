import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/categories.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics/analytics.dart';
import 'package:stockfare_mobile/screens/main_pages/dashboard/main_dashboard.dart';
import 'package:stockfare_mobile/screens/main_pages/home.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final PageStorageBucket bucket = PageStorageBucket();

  int _currentIndex = 0;
  final List<Widget> _tabs = [
    DashBoard(),
    HomePage(
      key: PageStorageKey('Page1'),
    ),
    CategoryPage(
      key: PageStorageKey('Page2'),
    ),
    AnalyticsPage(key: PageStorageKey('Page3')),
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
              Icons.dashboard,
              color: Hexcolor('#c80815'),
            ),
            title: Text(
              'Dashboard',
              style: TextStyle(
                color: Hexcolor('#c80815'),
              ),
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_basket,
              color: Hexcolor('#c80815'),
            ),
            title: Text(
              'Checkout',
              style: TextStyle(
                color: Hexcolor('#c80815'),
              ),
            ),
            backgroundColor: Colors.deepOrange,
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
            backgroundColor: Colors.green,
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
            backgroundColor: Colors.white,
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
