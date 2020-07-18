import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/sales_analytics_model.dart';
import 'package:stockfare_mobile/services/analytics_services.dart';

class SalesPageAnalytics extends StatefulWidget {
  @override
  _SalesPageAnalyticsState createState() => _SalesPageAnalyticsState();
}

class _SalesPageAnalyticsState extends State<SalesPageAnalytics> {
  Analytics _checkSales = Analytics();
  Future<SalesAnalytics> _salesAnalytics;

  @override
  void initState() {
    super.initState();
    _salesAnalytics = _checkSales.getAllAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SalesAnalytics>(
      future: _salesAnalytics,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  _todaySalesCount(context, snapshot.data.todaySalesAmount,
                      snapshot.data.todaySalesCount, 'Today Sales'),
                  SizedBox(
                    height: 10,
                  ),
                  _todaySalesCount(context, snapshot.data.weekSalesAmount,
                      snapshot.data.weekSalesCount, 'Week Sales'),
                  SizedBox(
                    height: 10,
                  ),
                  _todaySalesCount(context, snapshot.data.monthSalesAmount,
                      snapshot.data.monthSalesCount, 'Month Sales'),
                  SizedBox(
                    height: 10,
                  ),
                  _todaySalesCount(context, snapshot.data.quarterSalesAmount,
                      snapshot.data.quarterSalesCount, 'Quarter Sales'),
                  SizedBox(
                    height: 10,
                  ),
                  _todaySalesCount(context, snapshot.data.yearSalesAmount,
                      snapshot.data.yearSalesCount, 'Yearly Sales'),
                ]),
          );
        }
        return Text('Your Sales Analytics will diplay here');
      },
    );
  }
}

_todaySalesCount(context, amountSnapshot, salesSnapshot, date) {
  return Column(
    children: <Widget>[
      Container(
        width: 100,
        height: 40,
        color: Theme.of(context).primaryColor,
        child: Center(
            child: Text(
          date,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )),
      ),
      Container(
        margin: EdgeInsets.all(20),
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  date + ' Amount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  amountSnapshot.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Today Sales Count',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  salesSnapshot.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ])
          ],
        ),
      ),
    ],
  );
}
