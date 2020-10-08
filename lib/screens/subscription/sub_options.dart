import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/helpers/sub_helpers.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/screens/subscription/sub_home.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/payment_services.dart';

class SubOptions extends StatefulWidget {
  @override
  _SubOptionsState createState() => _SubOptionsState();
}

class _SubOptionsState extends State<SubOptions> {
  var testKey = 'pk_test_06b100bc626ea6bae0400111f8c7cbe604c93688';
  // var publicKey = 'pk_live_ef8036136f85c57cf6ef994d96d3badc59548882';
  PaymentServices _paymentServices = PaymentServices();
  ActivitiesServices _activitiesServices = ActivitiesServices();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;
  @override
  void initState() {
    super.initState();
    PaystackPlugin.initialize(publicKey: testKey);
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier = Provider.of<SignupNotifier>(context);
    String _email = _signupNotifier.email;
    return WillPopScope(
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SubscriptionPage())),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Select Payment Method '),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                DialogBoxes().promoCode(context);
              },
              child: Text('Use promo code'),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      chargeCard(_email);
                    },
                    child: Text(
                      'PAY WITH CARD',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      DialogBoxes().accountDetails(context);
                    },
                    child: Text(
                      'TRANSFER',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 320,
                  height: 50,
                  color: Colors.grey,
                  child: Center(
                      child: Text(
                    'Premium Plan',
                    style: TextStyle(fontSize: 18),
                  )),
                ),
                Container(
                    height: 400,
                    width: 320,
                    color: Colors.grey[200],
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 320,
                            height: 50,
                            color: Colors.grey[100],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Best for staff business',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 20),
                                )
                              ],
                            )),
                        Container(
                            width: 320,
                            height: 50,
                            color: Colors.grey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Access Unlimited Sales',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 20),
                                )
                              ],
                            )),
                        Container(
                            width: 320,
                            height: 50,
                            color: Colors.grey[100],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Access Business Analytics',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 20),
                                )
                              ],
                            )),
                        Container(
                            width: 320,
                            height: 50,
                            color: Colors.grey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Full Business Activities',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 20),
                                )
                              ],
                            )),
                        Container(
                            width: 320,
                            height: 50,
                            color: Colors.grey[100],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Receive Notification',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 20),
                                )
                              ],
                            )),
                        Container(
                            width: 320,
                            height: 50,
                            color: Colors.grey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Add Unlimited Goods',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 20),
                                )
                              ],
                            )),
                        Container(
                            width: 320,
                            height: 50,
                            color: Colors.grey[100],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Access Sales History',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 20),
                                )
                              ],
                            )),
                        Container(
                            width: 320,
                            height: 50,
                            color: Colors.grey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Add Your Workers',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 20),
                                )
                              ],
                            )),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> chargeCard(_email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('reference', _getReference());
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    Charge charge = Charge()
      ..amount = 250000
      ..reference = _getReference()
      ..email = _email;
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    if (response.status == true) {
      DialogBoxes().loading(context);
      _activitiesServices.checkForInternet().then((value) async {
        if (value == true) {
          dynamic result =
              await _paymentServices.sendPaymentToServer('PREMIUM').timeout(
                    Duration(seconds: 10),
                    onTimeout: () => null,
                  );
          if (result != true) {
            Navigator.pop(context);
            setState(() {
              result == null
                  ? _error = 'Opps! Error occured, please try again.'
                  : _error = result.toString();
              _displaySnackBar(context);
            });
          } else {
            Navigator.pop(context);
            DialogBoxes().success(context);
            Subscription().setPlanToPremium();
          }
        } else {
          setState(() {
            _error = 'Please check your internet connection';

            _displaySnackBar(context);
          });
        }
      });
    } else {
      return false;
    }
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
