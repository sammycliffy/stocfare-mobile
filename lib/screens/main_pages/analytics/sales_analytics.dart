import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/sales_analytics_model.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics/sales_report.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/analytics_services.dart';

class SalesPageAnalytics extends StatefulWidget {
  @override
  _SalesPageAnalyticsState createState() => _SalesPageAnalyticsState();
}

class _SalesPageAnalyticsState extends State<SalesPageAnalytics> {
  Analytics _checkSales = Analytics();
  Future<SalesAnalytics> _salesAnalytics;
  ActivitiesServices _activitiesServices = ActivitiesServices();
  bool isNetwork = true;
  String _errorData;
  bool _error = false;
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
          onTap: () {},
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
        return FutureBuilder<SalesAnalytics>(
            future: _checkSales.getAllAnalytics(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                controller
                    .updateValue(snapshot.data.monthSalesAmount.toDouble());
                controller1
                    .updateValue(snapshot.data.todaySalesAmount.toDouble());
                controller2
                    .updateValue(snapshot.data.weekSalesAmount.toDouble());
                controller3
                    .updateValue(snapshot.data.monthSalesAmount.toDouble());
                controller4
                    .updateValue(snapshot.data.quarterSalesCount.toDouble());
                controller5
                    .updateValue(snapshot.data.yearSalesAmount.toDouble());
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                          child: Container(
                        width: 420,
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        ' Stockfare provides you \n details of what sells and what \n doesn\'t',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.monthSalesCount
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(
                                        controller.text,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).primaryColor),
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
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: Card(
                              child: Container(
                                width: 150,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        controller1.text,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              _checkSales.analyticsDetails('day').then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AnalyticsDetailsPage(
                                                filterBy: 'day',
                                                analyticsData: value,
                                                pageTitle: 'Today\'s Report')));
                              });
                            },
                          ),
                          GestureDetector(
                            child: Card(
                              child: Container(
                                width: 150,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Sales This Week',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.weekSalesCount.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        controller2.text,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              _checkSales
                                  .analyticsDetails('week')
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AnalyticsDetailsPage(
                                                filterBy: 'week',
                                                analyticsData: value,
                                                pageTitle: 'Week\'s Report')));
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: Card(
                              child: Container(
                                width: 150,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        controller3.text,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              _checkSales
                                  .analyticsDetails('month')
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AnalyticsDetailsPage(
                                                filterBy: 'month',
                                                analyticsData: value,
                                                pageTitle: 'Month\'s Report')));
                              });
                            },
                          ),
                          GestureDetector(
                            child: Card(
                              child: Container(
                                width: 150,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Sales This Quarter',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.quarterSalesCount
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        controller4.text,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              _checkSales
                                  .analyticsDetails('quarter')
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AnalyticsDetailsPage(
                                                filterBy: 'quarter',
                                                analyticsData: value,
                                                pageTitle:
                                                    'Quarter\'s Report')));
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, right: 20),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        controller5.text,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _checkSales.analyticsDetails('year').then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnalyticsDetailsPage(
                                      filterBy: 'year',
                                      analyticsData: value,
                                      pageTitle: 'Year\'s Report')));
                        });
                      },
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
    }());
  }
}
