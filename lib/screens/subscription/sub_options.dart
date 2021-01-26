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
  // var testKey = 'pk_test_06b100bc626ea6bae0400111f8c7cbe604c93688';
  var publicKey = 'pk_live_ef8036136f85c57cf6ef994d96d3badc59548882';
  PaymentServices _paymentServices = PaymentServices();
  ActivitiesServices _activitiesServices = ActivitiesServices();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;
  @override
  void initState() {
    super.initState();
    PaystackPlugin.initialize(publicKey: publicKey);
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
          title: Text('Monthly '),
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
            SizedBox(
              height: 40,
            ),
            Container(
                width: 150,
                height: 180,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Monthly',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Subscription',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      'NGN 3,000',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 60,
                  width: 150,
                  child: RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        chargeCard(_email);
                      },
                      child: Text(
                        'PAY WITH CARD',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 60,
                  width: 150,
                  child: RaisedButton(
                      color: Colors.black,
                      onPressed: () {
                        DialogBoxes().accountDetails(context);
                      },
                      child: Text(
                        'TRANSFER',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
      ..amount = 3000
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
          dynamic result = await _paymentServices
              .sendPaymentToServer('PREMIUM', 'monthly')
              .timeout(
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
