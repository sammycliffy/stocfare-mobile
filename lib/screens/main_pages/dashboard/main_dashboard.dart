import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/sales_analytics_model.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_single_products/form.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/expenses/home.dart';
import 'package:stockfare_mobile/screens/main_pages/home.dart';
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

  @override
  void initState() {
    super.initState();

    _activitiesServices.checkForInternet().then((value) {
      if (value == true) {
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
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Icon(Icons.notifications, size: 30, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ActivitiesPage()));
              },
            ),
          ],
        ),
        drawer: DrawerPage(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 150),
              child: Text(
                'Welcome ${_signupNotifier.fullName}!',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _container('Add Goods', Hexcolor('#1D362A'),
                'Click here to add Product', FormPage()),
            SizedBox(height: 30),
            _container('Checkout', Theme.of(context).primaryColor,
                'Click here to create a sale', HomePage()),
            SizedBox(height: 30),
            _container('Expense & Income', Hexcolor('#727275'),
                'Click to record your business expenses', ExpensesHome()),
            SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 150),
              child: Text(
                'YOUR BUSINESS REPORT',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold),
              ),
            ),
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
                return Container(
                  height: 100,
                  child: FutureBuilder<SalesAnalytics>(
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
                          return ListView(
                            // This next line does the trick.
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              _daysCount('Today', controller1.text),
                              _daysCount('Week', controller2.text),
                              _daysCount('Month', controller3.text),
                              _daysCount('Quarter', controller4.text),
                              _daysCount('Year', controller5.text)
                            ],
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                );
              }
            }())
          ],
        )));
  }

  _daysCount(date, prices) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Hexcolor('#40A099'),
              borderRadius: BorderRadius.circular(10)),
          width: 180.0,
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                date,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
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
        padding: const EdgeInsets.only(left: 15, top: 5, right: 10),
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
                    fontSize: 25,
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
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => route)));
}
