import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics/product_analytics.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics/sales_analytics.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key key}) : super(key: key);
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            drawer: DrawerPage(),
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'Sales',
                  ),
                  Tab(
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
                    SalesPageAnalytics(),
                    ProductPageAnalytics(),
                  ],
                ),
              ),
            ])));
  }
}
