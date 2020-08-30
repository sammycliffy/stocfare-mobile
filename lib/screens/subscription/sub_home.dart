import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stockfare_mobile/screens/subscription/sub_options.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  String subscriptionPlan;

  @override
  void initState() {
    super.initState();
    setState(() {
      checkSubscription().then((value) => subscriptionPlan = value);
    });
  }

  Future<String> checkSubscription() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String subscriptionPlan = sharedPreferences.getString('subscription_plan');
    return subscriptionPlan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            height: 70,
                            child: Center(
                              child: Text(
                                'PREMIUM PLAN',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SubOptions()));
                  },
                )
              ],
            )
          ],
        ));
  }
}
