import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stockfare_mobile/intro_pages/add_product_intro.dart';
import 'package:stockfare_mobile/intro_pages/sales_intro.dart';
import 'package:stockfare_mobile/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/main_pages/common_widget/main_app_bar.dart';
import 'package:stockfare_mobile/main_pages/home.dart';
import 'package:stockfare_mobile/main_pages/product_History.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;
  List<Widget> _tabs = [
    HomeScreen(),
    ProductHistoryPage(),
    SalesIntroPage(),
    Center(child: Text('Page 4'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: MainAppBar.appBarFunction(context)),
      drawer: DrawerPage(),
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
