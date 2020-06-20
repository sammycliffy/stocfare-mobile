import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'all_products.dart';

class SalesIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Sales',
                style: TextStyle(fontSize: 20, color: Colors.grey[900]),
              ),
              Text('Stockfare App',
                  style: TextStyle(fontSize: 16, color: Colors.grey[900])),
              SizedBox(
                height: 30,
              ),
              Text(
                'Try out add new Sales ',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              Text('to your Stockfare App',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  child: Icon(Icons.add, color: Colors.white, size: 40),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: AllProductPage()));
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text('Make a sale',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800])),
              SizedBox(
                height: 40,
              ),
              Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Icon(
                    Icons.assessment,
                    color: Colors.grey,
                    size: 50,
                  )),
              SizedBox(
                height: 10,
              ),
              Text('Scan Barcode',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800])),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }
}
