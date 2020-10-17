import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/subscription/annual.dart';
import 'package:stockfare_mobile/screens/subscription/sub_options.dart';

class PaymentOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('Payment Option')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Card(
                      child: Container(
                          width: 150,
                          height: 180,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Annual',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Subscription',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Divider(),
                              ),
                              Text(
                                'NGN 36,000',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey[600],
                                    fontSize: 18),
                              ),
                              Text(
                                'NGN 30,000',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnnualPage()));
                    },
                  ),
                  GestureDetector(
                    child: Card(
                      child: Container(
                          width: 150,
                          height: 180,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Monthly',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Subscription',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Divider(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'NGN 3,000',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubOptions()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
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
                      height: 600,
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                    'Manage Expense and Income',
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                    'Track Customers',
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                    'View Profit & Loss',
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
        ));
  }

  annual(context) {
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
}
