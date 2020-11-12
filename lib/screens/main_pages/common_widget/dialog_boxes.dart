import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/subscription/sub_home.dart';
import 'package:stockfare_mobile/services/payment_services.dart';
import 'package:url_launcher/url_launcher.dart';

enum SingingCharacter { pack, unit }

class DialogBoxes {
  PaymentServices _paymentServices = PaymentServices();
  loading(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Just a moment',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              CircularProgressIndicator()
            ],
          )),
        );
      },
    );
  }

  upgrader(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'App update Available',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'A new version of the app is available',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor),
                    child: Center(
                        child: Text('Update',
                            style: TextStyle(color: Colors.white)))),
                onTap: () {
                  _launchURL();
                },
              )
            ],
          )),
        );
      },
    );
  }

  _launchURL() async {
    const url = 'https://play.google.com/store/apps/details?id=com.stockfare';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  productOutOfRange(context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Icon(
                Icons.mood_bad,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Sorry! This product is out of Stock',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          )),
        );
      },
    );
  }

  invalidSubscription(context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Icon(
                Icons.mood_bad,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Your current plan does not support this activity. \nPlease upgrade to enjoy.',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(height: 5),
              GestureDetector(
                child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text('Upgrade',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)))),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubscriptionPage())),
              )
            ],
          )),
        );
      },
    );
  }

  accountDetails(context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Bank Details',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Account Name',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('Contrail Stores Ltd',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        'Account Number',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('0565459962',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        'Account Bank',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('GTBank',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        'CONTACT NUMBER',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('08109980086',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ))
            ],
          )),
        );
      },
    );
  }

  promoCode(context) {
    String _promoCode;
    String _result = '';
    bool _error = false;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Text(
                    'APPLY A PROMO CODE',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    _result,
                    style: TextStyle(
                        color: _error ? Colors.red : Colors.green,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onChanged: (val) => setState(() {
                      _promoCode = val;
                    }),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2))),
                      hintStyle: TextStyle(
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
                      hintText: 'Enter Promo code',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.5))),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                      onPressed: () {
                        _paymentServices.promoCode(_promoCode).then((value) {
                          if (value == true) {
                            setState(() {
                              _result = 'Success!';
                            });
                          } else {
                            setState(() {
                              _error = true;
                              _result = 'Invalid Promo code';
                            });
                          }
                        });
                      },
                      color: Colors.black,
                      child: Text(
                        'Apply Code',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                  Text('Promo code will be applied on next payment')
                ],
              ));
            }));
      },
    );
  }

  success(context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Updated Successfully',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 60,
                ),
              )
            ],
          )),
        );
      },
    );
  }
}
