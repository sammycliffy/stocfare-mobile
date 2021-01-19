import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics/product_analytics.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics/sales_analytics.dart';

import 'profit_loss.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key key}) : super(key: key);
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  goback(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: WillPopScope(
          onWillPop: () {
            return goback(context);
          },
          child: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                  Colors.red[200],
                  Colors.white,
                ],
                    stops: [
                  0.0,
                  1.0
                ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    tileMode: TileMode.repeated)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
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
                      Tab(
                        text: 'Profits',
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
                        ProfitAndLossPage(),
                      ],
                    ),
                  ),
                ])),
          ),
        ));
  }
}
