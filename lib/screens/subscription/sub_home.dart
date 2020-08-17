import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  var publicKey = 'pk_test_06b100bc626ea6bae0400111f8c7cbe604c93688';

  @override
  void initState() {
    super.initState();
    PaystackPlugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Subscription'),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {},
              child: Text('Use promo code'),
            )
          ],
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
                Card(
                    color: Colors.grey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 70,
                          child: Center(
                            child: Text(
                              'BASIC PLAN',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: 150,
                          height: 70,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Price',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
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
                SizedBox(
                  width: 10,
                ),
                Card(
                    color: Colors.black,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 70,
                          child: Center(
                            child: Text(
                              'PREMIUM PLAN',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: 150,
                          height: 70,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Price',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
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
                    ))
              ],
            )
          ],
        ));
  }
}
