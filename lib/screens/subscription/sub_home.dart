import 'package:flutter/material.dart';

class SubscriptionPage extends StatelessWidget {
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
            )
          ],
        ));
  }
}
