// Flutter code sample for NavigationRail

// This example shows a [NavigationRail] used within a Scaffold with 3
// [NavigationRailDestination]s. The main content is separated by a divider
// (although elevation on the navigation rail can be used instead). The
// `_selectedIndex` is updated by the `onDestinationSelected` callback.

import 'package:flutter/material.dart';

class ProductHistoryPage extends StatefulWidget {
  ProductHistoryPage({Key key}) : super(key: key);

  @override
  _ProductHistoryPageState createState() => _ProductHistoryPageState();
}

class _ProductHistoryPageState extends State<ProductHistoryPage> {
  int _currentIndex = 0;

  List<Widget> _tabs = [
    ListView(
      shrinkWrap: true,
      children: const <Widget>[
        Card(child: ListTile(title: Text('One-line ListTile'))),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with leading widget'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line with trailing widget'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with both widgets'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line dense ListTile'),
            dense: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text('Two-line ListTile'),
            subtitle: Text('Here is a second line'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
      ],
    ),
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
          Flexible(
            child: _tabs[_currentIndex],
          )
        ]));
  }
}
