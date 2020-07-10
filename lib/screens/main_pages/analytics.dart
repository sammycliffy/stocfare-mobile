import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.white,
            drawer: DrawerPage(),
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.monetization_on),
                    text: 'Sales',
                  ),
                  Tab(
                    icon: Icon(Icons.shopping_cart),
                    text: 'Products',
                  ),
                ],
              ),
              title: Text('Product Analytics'),
            ),
            body: Column(children: [
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: Text('jane'),
                    ),
                    Center(
                      child: Text('tobi'),
                    )
                  ],
                ),
              ),
              Container(
                height: 40,
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: 160.0,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'Today',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: 160.0,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text('This week',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      width: 160.0,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text('This month',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      width: 160.0,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text('This quarter',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      width: 160.0,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text('This year',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
