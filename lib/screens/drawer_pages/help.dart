import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('Help')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'In order to quickly get you stated, we have curated a few things you need to have the best Stockfare experience.',
                style: TextStyle(fontSize: 16, height: 1.2),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
                width: 330,
                height: 40,
                color: Colors.white,
                child: Center(
                    child: Text(
                  ' What is Stockfare?',
                  style: TextStyle(fontSize: 15),
                ))),
            SizedBox(
              height: 15,
            ),
            Container(
                width: 330,
                height: 40,
                color: Colors.white,
                child: Center(
                    child: Text(
                  ' What do we mean by Category',
                  style: TextStyle(fontSize: 15),
                ))),
            SizedBox(
              height: 15,
            ),
            Container(
                width: 330,
                height: 40,
                color: Colors.white,
                child: Center(
                    child: Text(
                  'How do I add my product?',
                  style: TextStyle(fontSize: 15),
                ))),
            SizedBox(
              height: 15,
            ),
            Container(
                width: 330,
                height: 40,
                color: Colors.white,
                child: Center(
                    child: Text(
                  'How do I register a sale?',
                  style: TextStyle(fontSize: 15),
                ))),
            SizedBox(
              height: 15,
            ),
            Container(
                width: 330,
                height: 65,
                color: Colors.white,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Do i  have to manually update my inventory when i sell?',
                    style: TextStyle(fontSize: 15),
                  ),
                ))),
            SizedBox(
              height: 15,
            ),
            Container(
                width: 330,
                height: 45,
                color: Colors.white,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'How do i add my staff on my account?',
                    style: TextStyle(fontSize: 15),
                  ),
                ))),
            SizedBox(
              height: 15,
            ),
            Container(
                width: 330,
                height: 40,
                color: Colors.white,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'What\'s the pricing plan?',
                    style: TextStyle(fontSize: 15),
                  ),
                ))),
          ],
        ));
  }
}
