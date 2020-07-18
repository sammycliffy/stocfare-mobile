import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/sales_analytics_model.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/product_analytics.dart';
import 'package:stockfare_mobile/screens/main_pages/sales_analytics.dart';

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
                    SalesPageAnalytics(),
                    ProductPageAnalytics(),
                  ],
                ),
              ),
            ])));
  }
}
