import 'package:flutter/material.dart';
import 'package:stockfare_mobile/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/main_pages/common_widget/main_app_bar.dart';
import 'package:stockfare_mobile/main_pages/home.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;
  List<Widget> _tabs = [
    HomeScreen(),
    Center(child: Text('Page 2')),
    Center(child: Text('Page 3')),
    Center(child: Text('Page 4'))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar.appBarFunction(),
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
              color: Colors.red,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard, color: Colors.red),
            title: Text(
              'Products',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Colors.deepOrange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on, color: Colors.red),
            title: Text(
              'Sales',
              style: TextStyle(color: Colors.red),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.multiline_chart, color: Colors.red),
            title: Text(
              'Analytics',
              style: TextStyle(color: Colors.red),
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
