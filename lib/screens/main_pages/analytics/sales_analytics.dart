import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/sales_analytics_model.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics/sales_report.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/analytics_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SalesPageAnalytics extends StatefulWidget {
  @override
  _SalesPageAnalyticsState createState() => _SalesPageAnalyticsState();
}

class _SalesPageAnalyticsState extends State<SalesPageAnalytics> {
  Analytics _checkSales = Analytics();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<SalesAnalytics> _salesAnalytics;
  ActivitiesServices _activitiesServices = ActivitiesServices();

  bool isNetwork = true;
  String _errorData;
  bool _error = false;
  void _onRefresh() async {
    setState(() {
      _checkSales.refreshGetAllAnalytics();
    });
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  // void _onLoading() async{
  //   // monitor network fetch
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   // if failed,use loadFailed(),if no data return,use LoadNodata()
  //   items.add((items.length+1).toString());
  //   if(mounted)
  //   setState(() {

  //   });
  //   _refreshController.loadComplete();
  // }
  @override
  void initState() {
    super.initState();
    _activitiesServices.checkForInternet().then((value) {
      if (value == true) {
        _checkSales.getAllAnalytics().catchError((e) {
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

  @override
  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    var controller = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    var controller1 = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    var controller2 = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    var controller3 = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    var controller4 = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    var controller5 = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
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
                  Icons.signal_cellular_connected_no_internet_4_bar,
                  size: 40,
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'no Internet',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          onTap: () {},
        );
      } else if (_error == true) {
        return Center(
          child: Text(
            _errorData ?? 'Sorry an Error',
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
            child: Column(
              children: [
                FutureBuilder<SalesAnalytics>(
                    future: _checkSales.getAllAnalytics(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        controller.updateValue(
                            snapshot.data.monthSalesAmount.toDouble());
                        controller1.updateValue(
                            snapshot.data.todaySalesAmount.toDouble());
                        controller2.updateValue(
                            snapshot.data.weekSalesAmount.toDouble());
                        controller3.updateValue(
                            snapshot.data.monthSalesAmount.toDouble());
                        controller4.updateValue(
                            snapshot.data.quarterSalesAmount.toDouble());
                        controller5.updateValue(
                            snapshot.data.yearSalesAmount.toDouble());
                        return SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Card(
                                    child: Container(
                                  width: 420,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            'Find below details of your daily, weekly, monthly, quarterly, & yearly sales..',
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 10, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  'Sales Today',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data.todaySalesCount
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  controller1.text,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // onTap: () {
                                      //   _checkSales
                                      //       .analyticsDetails('day')
                                      //       .then((value) {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 AnalyticsDetailsPage(
                                      //                     filterBy: 'day',
                                      //                     analyticsData: value,
                                      //                     pageTitle:
                                      //                         'Today\'s Report')));
                                      //   });
                                      // },
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  'Sales This Week',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data.weekSalesCount
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  controller2.text,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // onTap: () {
                                      //   _checkSales
                                      //       .analyticsDetails('week')
                                      //       .then((value) {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 AnalyticsDetailsPage(
                                      //                     filterBy: 'week',
                                      //                     analyticsData: value,
                                      //                     pageTitle:
                                      //                         'Week\'s Report')));
                                      //   });
                                      // },
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 10, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  'Sales This Month',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data.monthSalesCount
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  controller3.text,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // onTap: () {
                                      //   _checkSales
                                      //       .analyticsDetails('month')
                                      //       .then((value) {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 AnalyticsDetailsPage(
                                      //                     filterBy: 'month',
                                      //                     analyticsData: value,
                                      //                     pageTitle:
                                      //                         'Month\'s Report')));
                                      //   });
                                      // },
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  'Sales This Quarter',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data.quarterSalesCount
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  controller4.text,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // onTap: () {
                                      //   _checkSales
                                      //       .analyticsDetails('quarter')
                                      //       .then((value) {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 AnalyticsDetailsPage(
                                      //                     filterBy: 'quarter',
                                      //                     analyticsData: value,
                                      //                     pageTitle:
                                      //                         'Quarter\'s Report')));
                                      //   });
                                      // },
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 10, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Card(
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  'Sales This Year',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data.yearSalesCount
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  controller5.text,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // onTap: () {
                                //   _checkSales
                                //       .analyticsDetails('year')
                                //       .then((value) {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 AnalyticsDetailsPage(
                                //                     filterBy: 'year',
                                //                     analyticsData: value,
                                //                     pageTitle:
                                //                         'Year\'s Report')));
                                //   });
                                // },
                              )
                            ],
                          ),
                        );
                      } else {
                        return Column(children: [LinearProgressIndicator()]);
                      }
                    }),
              ],
            ),
          ),
        );
      }
    }());
  }
}
