import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/helpers/sub_helpers.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/screens/subscription/sub_options.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/payment_services.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  String subscriptionPlan;
  PaymentServices _paymentServices = PaymentServices();
  ActivitiesServices _activitiesServices = ActivitiesServices();
  String subscription = '';
  Future<String> sub = Subscription().getSubscriptionPlan();
  var _error;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    sub.then((value) {
      setState(() {
        subscription = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationPage())),
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Subscription'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'CHOOSE A PLAN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'CURRENT PLAN (BASIC)',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Card(
                        color: Colors.grey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'BASIC PLAN',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            subscription != 'PREMIUM'
                                ? Icon(
                                    Icons.check,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : SizedBox(),
                            Container(
                              color: Colors.white,
                              width: 150,
                              height: 70,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  Text(
                                    'FREE',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    onTap: () {
                      _activitiesServices
                          .checkForInternet()
                          .then((value) async {
                        if (value == true) {
                          DialogBoxes().loading(context);
                          dynamic result =
                              await _paymentServices.switchPlan('FREE').timeout(
                                  Duration(
                                    seconds: 10,
                                  ),
                                  onTimeout: () => null);

                          if (result != true) {
                            Navigator.pop(context);
                            setState(() {
                              result == null
                                  ? _error =
                                      'Opps! Error occured, please try again.'
                                  : _error = result.toString();
                              _displaySnackBar(context);
                            });
                          } else {
                            Navigator.pop(context);
                            Subscription().setPlanToFree();
                            DialogBoxes().success(context);
                            Subscription().getSubscriptionPlan().then((value) {
                              setState(() {
                                subscription = value;
                              });
                            });
                          }
                        } else {
                          setState(() {
                            _error = 'Please check your internet connection';

                            _displaySnackBar(context);
                          });
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Card(
                        color: Colors.black,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'PREMIUM PLAN',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            subscription == 'PREMIUM'
                                ? Icon(
                                    Icons.check,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : SizedBox(),
                            Container(
                              color: Colors.white,
                              width: 150,
                              height: 70,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  Text(
                                    'NGN 2,500',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    onTap: () {
                      // chargeCard(_email);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubOptions()));
                    },
                  )
                ],
              )
            ],
          )),
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          _error.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
