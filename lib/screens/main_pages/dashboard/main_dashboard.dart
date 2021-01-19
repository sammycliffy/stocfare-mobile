import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/sales_analytics_model.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';
import 'package:stockfare_mobile/screens/main_pages/accounting/balance_sheet.dart';
import 'package:stockfare_mobile/screens/main_pages/accounting/cashflow.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_single_products/form.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/dashboard/carousel.dart';
import 'package:stockfare_mobile/screens/main_pages/expenses/home.dart';
import 'package:stockfare_mobile/screens/main_pages/sales_report/sales_report.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/analytics_services.dart';

import '../activities_pages.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Analytics _checkSales = Analytics();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Future<SalesAnalytics> _salesAnalytics;
  ActivitiesServices _activitiesServices = ActivitiesServices();
  bool isNetwork = true;
  String _errorData;
  bool _error = false;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          isNetwork = false;
        });
      } else {
        setState(() {
          isNetwork = true;
        });
      }
    });
    _checkSales.getAllAnalytics().catchError((e) {
      if (e == "Given token not valid for any token type") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        setState(() {
          _error = true;
          _errorData = e.toString();
        });
      }
    });
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
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
    return WillPopScope(
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Text(
              'Home',
            ),
            actions: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child:
                      Icon(Icons.notifications, size: 30, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ActivitiesPage()));
                },
              ),
            ],
          ),
          drawer: DrawerPage(),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      'Welcome ${_signupNotifier.fullName}!',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  // Container(
                  //   height: 60,
                  //   width: 50,
                  //   decoration: BoxDecoration(
                  //       color: Colors.green[300],
                  //       border: Border.all(color: Colors.white, width: 3),
                  //       borderRadius: BorderRadius.circular(8)),
                  //   child: Center(
                  //       child: Text(
                  //     'Wallet',
                  //     style: TextStyle(
                  //         color: Colors.white, fontWeight: FontWeight.bold),
                  //   )),
                  // ),
                ],
              ),

              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormPage())),
                child: Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/add.png'),
                    title: Text('Add Product',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text('Click to add product'),
                    trailing:
                        Icon(Icons.arrow_forward, size: 30, color: Colors.blue),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  SignupNotifier _signupNotifier =
                      Provider.of<SignupNotifier>(context, listen: false);
                  _signupNotifier.setPageNumber(1);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationPage()));
                },
                child: Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/checkout.png'),
                    title: Text('Checkout',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text('Click to create a sale'),
                    trailing:
                        Icon(Icons.arrow_forward, size: 30, color: Colors.blue),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExpensesHome()));
                },
                child: Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/monthly.png'),
                    title: Text('Monthly Expense',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text('Click to create a sale'),
                    trailing:
                        Icon(Icons.arrow_forward, size: 30, color: Colors.blue),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BalanceSheet()));
                },
                child: Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/balancesheet.png'),
                    title: Text('Balance Sheet',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text('Click to generate Balance Sheet'),
                    trailing:
                        Icon(Icons.arrow_forward, size: 30, color: Colors.blue),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SalesReportPage()));
                },
                child: Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/report.png'),
                    title: Text('Sales Report',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text('Click to generate Report'),
                    trailing:
                        Icon(Icons.arrow_forward, size: 30, color: Colors.blue),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CashFlow()));
                },
                child: Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/cashflow.png'),
                    title: Text('Cash Flow',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text('Click to generate Balance Sheet'),
                    trailing:
                        Icon(Icons.arrow_forward, size: 30, color: Colors.blue),
                  ),
                ),
              ),

              ImageSlider(),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5, right: 150),
              //   child: Text(
              //     'YOUR BUSINESS REPORT',
              //     style: TextStyle(
              //         fontSize: 18,
              //         color: Colors.grey[800],
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              (() {
                if (_error == true) {
                  return Center(
                    child: Text(
                      _errorData,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  return isNetwork == false
                      ? Center(child: Text('No Internet'))
                      : SizedBox();
                  // : Container(
                  //     height: 50,
                  //     child: FutureBuilder<SalesAnalytics>(
                  //         future: _checkSales.getAllAnalytics(),
                  //         builder: (context, snapshot) {
                  //           if (snapshot.hasData) {
                  //             controller.updateValue(
                  //                 snapshot.data.monthSalesAmount.toDouble());
                  //             controller1.updateValue(
                  //                 snapshot.data.todaySalesAmount.toDouble());
                  //             controller2.updateValue(
                  //                 snapshot.data.weekSalesAmount.toDouble());
                  //             controller3.updateValue(
                  //                 snapshot.data.monthSalesAmount.toDouble());
                  //             controller4.updateValue(snapshot
                  //                 .data.quarterSalesAmount
                  //                 .toDouble());
                  //             controller5.updateValue(
                  //                 snapshot.data.yearSalesAmount.toDouble());
                  //             return ListView(
                  //               // This next line does the trick.
                  //               scrollDirection: Axis.horizontal,
                  //               children: <Widget>[
                  //                 _daysCount('Today', controller1.text),
                  //                 _daysCount('Week', controller2.text),
                  //                 _daysCount('Month', controller3.text),
                  //                 _daysCount('Quarter', controller4.text),
                  //                 _daysCount('Year', controller5.text)
                  //               ],
                  //             );
                  //           }
                  //           return Center(child: SizedBox());
                  //         }),
                  //   );
                }
              }())
            ],
          ))),
    );
  }

  _daysCount(date, prices) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(5)),
          width: 180.0,
          child: Column(
            children: [
              SizedBox(height: 5),
              Text(
                date,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                prices,
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          ),
        ),
      );
  _container(name, color, description, route) => GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 5, right: 5),
        width: 350,
        height: 95,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), color: color
                // gradient: LinearGradient(
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                //   stops: [0.1, 0.5, 0.7, 0.9],
                //   colors: [
                //     color[400],
                //     color[600],
                //     color[700],
                //     color[800],
                //   ],
                // ),
                ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(description,
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              Icon(Icons.arrow_forward, size: 30, color: Colors.white),
            ])
          ],
        ),
      ),
      onTap: () {
        SignupNotifier _signupNotifier =
            Provider.of<SignupNotifier>(context, listen: false);
        _signupNotifier.setPageNumber(1);
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      });
}
