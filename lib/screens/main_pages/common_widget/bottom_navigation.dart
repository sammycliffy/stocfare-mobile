import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
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
    SignupNotifier _signupNotifier = Provider.of<SignupNotifier>(context);
    print('${_signupNotifier.pageNumber} this is page number');

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(
        child: _tabs[_signupNotifier.pageNumber],
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
              color: Colors.black,
            ),
            title: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.black,
            ),
            title: Text(
              'Checkout',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.deepOrange,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_giftcard,
              color: Colors.black,
            ),
            title: Text(
              'Products',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.multiline_chart,
              color: Colors.black,
            ),
            title: Text(
              'Analytics',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ],
        onTap: (index) {
          _signupNotifier.setPageNumber(index);
        },
      ),
    );
  }
}
