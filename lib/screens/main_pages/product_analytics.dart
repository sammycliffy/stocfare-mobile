import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/products_analytics_model.dart';
import 'package:stockfare_mobile/services/analytics_services.dart';

class ProductPageAnalytics extends StatefulWidget {
  @override
  _ProductPageAnalyticsState createState() => _ProductPageAnalyticsState();
}

class _ProductPageAnalyticsState extends State<ProductPageAnalytics> {
  Analytics _checkproduct = Analytics();
  Future<ProductsAnalyticsModel> _productAnalytics;

  @override
  void initState() {
    super.initState();
    _productAnalytics = _checkproduct.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductsAnalyticsModel>(
        future: _productAnalytics,
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
                          Text('Most Sold Product',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      snapshot.data.mostProductWeekName,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  snapshot.data.mostProductSalesWeekCount
                                          .toString() +
                                      ' Sold',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Least Sold This\n Week',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  snapshot.data.leastProductWeekName.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data.leastProductSalesWeekCount
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 150,
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Most Sold This \nWeek',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  snapshot.data.mostProductWeekName,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data.mostProductSalesWeekCount
                                      .toString(),
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
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Least Sold This Month',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  snapshot.data.leastProductMonthName,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Sold ' +
                                      snapshot.data.leastProductSalesMonthCount
                                          .toString() +
                                      ' time (s)',
                                  style: TextStyle(
                                      fontSize: 16,
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
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Most Sold This Month',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  snapshot.data.mostProductMonthName,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Sold ' +
                                      snapshot.data.mostProductSalesMonthCount
                                          .toString() +
                                      ' time (s)',
                                  style: TextStyle(
                                      fontSize: 16,
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
                    child: Text('Your Product Analytics',
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
