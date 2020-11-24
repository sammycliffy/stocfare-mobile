import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stockfare_mobile/models/products_analytics_model.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics/product_report.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/analytics_services.dart';

class ProductPageAnalytics extends StatefulWidget {
  @override
  _ProductPageAnalyticsState createState() => _ProductPageAnalyticsState();
}

class _ProductPageAnalyticsState extends State<ProductPageAnalytics> {
  Analytics _checkproduct = Analytics();
  Future<ProductsAnalyticsModel> _productAnalytics;
  ActivitiesServices _activitiesServices = ActivitiesServices();
  bool _error = false;
  String _errorData = '';
  bool isNetwork = true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _activitiesServices.checkForInternet().then((value) {
      if (value == true) {
        _checkproduct.getAllProducts().catchError((e) {
          setState(() {
            _error = true;
            _errorData = e.toString();
          });
        });
      } else {
        setState(() {
          isNetwork = false;
        });
      }
    });
  }

  void _onRefresh() async {
    setState(() {
      _checkproduct.refreshGetAllAnalytics();
    });
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return (() {
      if (isNetwork == false) {
        return GestureDetector(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 200),
                Icon(
                  Icons.mood_bad,
                  size: 40,
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'An error occured',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            setState(() {});
          },
        );
      } else if (_error == true) {
        return Center(
          child: Text(
            _errorData,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        );
      } else {
        return SmartRefresher(
          enablePullDown: true,
          // enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: FutureBuilder<ProductsAnalyticsModel>(
                future: _checkproduct.getAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
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
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                snapshot
                                                    .data.mostProductWeekName,
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
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            snapshot.data
                                                    .mostProductSalesWeekCount
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
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  child: Card(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Least Sold This\n Week',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data.leastProductWeekName
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data
                                                  .leastProductSalesWeekCount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _checkproduct
                                        .productsAnalyticsDetails(
                                            'least_sold_week')
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductsAnalyticsDetailsPage(
                                                      analyticsData: value,
                                                      pageTitle:
                                                          'LEAST SOLD WEEK\'S REPORT')));
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Card(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data
                                                  .mostProductSalesWeekCount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _checkproduct
                                        .productsAnalyticsDetails(
                                            'most_sold_week')
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductsAnalyticsDetailsPage(
                                                      analyticsData: value,
                                                      pageTitle:
                                                          'MOST SOLD WEEK\'S REPORT')));
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  child: Card(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Least Sold This Month',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot
                                                  .data.leastProductMonthName,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Sold ' +
                                                  snapshot.data
                                                      .leastProductSalesMonthCount
                                                      .toString() +
                                                  ' time (s)',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _checkproduct
                                        .productsAnalyticsDetails(
                                            'least_sold_month')
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductsAnalyticsDetailsPage(
                                                      analyticsData: value,
                                                      pageTitle:
                                                          'LEAST SOLD MONTH\'S REPORT')));
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Card(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Most Sold This Month',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot
                                                  .data.mostProductMonthName,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Sold ' +
                                                  snapshot.data
                                                      .mostProductSalesMonthCount
                                                      .toString() +
                                                  ' time (s)',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _checkproduct
                                        .productsAnalyticsDetails(
                                            'most_sold_month')
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductsAnalyticsDetailsPage(
                                                      analyticsData: value,
                                                      pageTitle:
                                                          'MOST SOLD MONTH\'S REPORT')));
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  child: Card(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Most Sold by Quarter',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot
                                                  .data.mostProductQuarterName,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Sold ' +
                                                  snapshot.data
                                                      .mostProductSalesQuarterCount
                                                      .toString() +
                                                  ' time (s)',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _checkproduct
                                        .productsAnalyticsDetails(
                                            'least_sold_month')
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductsAnalyticsDetailsPage(
                                                      analyticsData: value,
                                                      pageTitle:
                                                          'LEAST SOLD MONTH\'S REPORT')));
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(children: [LinearProgressIndicator()]);
                  }
                }),
          ),
        );
      }
    }());
  }
}
