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
          return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 40,
                        color: Theme.of(context).accentColor,
                        child: Center(
                            child: Text(
                          'Most Product Sold this Week',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                      ),
                      SizedBox(width: 100),
                      Icon(Icons.star, size: 40, color: Colors.orange)
                    ],
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
                              ' Product Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              snapshot.data.mostProductWeekName.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Product Count',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              snapshot.data.mostProductSalesWeekCount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  //Second
                  Row(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 40,
                        color: Theme.of(context).primaryColor,
                        child: Center(
                            child: Text(
                          'Least Product Sold this Week',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                      ),
                      SizedBox(width: 100),
                      Icon(Icons.mood_bad, size: 40, color: Colors.orange)
                    ],
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
                              ' Product Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              snapshot.data.leastProductWeekName.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Product Count',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              snapshot.data.leastProductSalesWeekCount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //Third
                  Row(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 40,
                        color: Theme.of(context).accentColor,
                        child: Center(
                            child: Text(
                          'Most sold product this Month',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                      ),
                      SizedBox(width: 100),
                      Icon(Icons.star, size: 40, color: Colors.orange)
                    ],
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
                              ' Product Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              snapshot.data.mostProductMonthName.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Product Count',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              snapshot.data.mostProductSalesMonthCount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  //fourth
                  Row(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 40,
                        color: Theme.of(context).primaryColor,
                        child: Center(
                            child: Text(
                          'Least Product Sold this Month',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                      ),
                      SizedBox(width: 100),
                      Icon(Icons.mood_bad, size: 40, color: Colors.orange)
                    ],
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
                              ' Product Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              snapshot.data.leastProductMonthName.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Product Count',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              snapshot.data.leastProductSalesMonthCount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                ]),
          );
        }
        return Text('Your Sales Analytics will diplay here');
      },
    );
  }
}
