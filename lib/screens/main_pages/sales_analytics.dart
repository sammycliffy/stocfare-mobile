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
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Card(
                      child: Container(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Sales Made This Month',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    ' StockFare provides you \n details of what sells and what \n doesn\'t',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    snapshot.data.monthSalesCount.toString(),
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data.monthSalesAmount.toString(),
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Card(
                        child: Container(
                          width: 150,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Sales Today',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  snapshot.data.todaySalesCount.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data.todaySalesAmount.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 150,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Sales This Week',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  snapshot.data.weekSalesCount.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data.weekSalesAmount.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Card(
                        child: Container(
                          width: 150,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Sales This Month',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  snapshot.data.monthSalesCount.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data.monthSalesAmount.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 150,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Sales This Quarter',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  snapshot.data.quarterSalesCount.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data.quarterSalesAmount.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Card(
                        child: Container(
                          width: 150,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Sales This Year',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  snapshot.data.yearSalesCount.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data.yearSalesAmount.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.monetization_on,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Center(
                    child: Text('Your Sales Analytics',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
                  ),
                ]);
          }
        });
  }
}
