// Flutter code sample for NavigationRail

// This example shows a [NavigationRail] used within a Scaffold with 3
// [NavigationRailDestination]s. The main content is separated by a divider
// (although elevation on the navigation rail can be used instead). The
// `_selectedIndex` is updated by the `onDestinationSelected` callback.

import 'package:flutter/material.dart';
import 'package:stockfare_mobile/main_pages/all_products_list/available.dart';

class ProductHistoryPage extends StatefulWidget {
  ProductHistoryPage({Key key}) : super(key: key);

  @override
  _ProductHistoryPageState createState() => _ProductHistoryPageState();
}

class _ProductHistoryPageState extends State<ProductHistoryPage> {
  int _currentIndex = 0;

  List<Widget> _tabs = [
    ProductsAvailable(),
    Text('two'),
    Text('three'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(children: <Widget>[
          NavigationRail(
            selectedIndex: _currentIndex,
            backgroundColor: Colors.white,
            onDestinationSelected: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border, color: Colors.red),
                selectedIcon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                label: Text('First', style: TextStyle(color: Colors.red)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border, color: Colors.red),
                selectedIcon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                label: Text('First', style: TextStyle(color: Colors.red)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border, color: Colors.red),
                selectedIcon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                label: Text('First', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          VerticalDivider(thickness: 2, width: 1, color: Colors.white),
          // This is the main content.
          Container(
            color: Colors.white,
            width: 310,
            child: _tabs[_currentIndex],
          )
        ]));
  }
}
