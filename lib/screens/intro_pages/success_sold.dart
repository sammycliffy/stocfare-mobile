import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';

class SuccessSold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/images/product_added.png')),
                Text(
                  'Products Sold',
                  style: TextStyle(fontSize: 25, color: Colors.blue[800]),
                ),
                Text(
                  'Successfully',
                  style: TextStyle(fontSize: 25, color: Colors.blue[800]),
                ),
              ],
            )),
            GestureDetector(
                child: Center(
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Sell Product',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: Login()));
                }),
            SizedBox(
              height: 30,
            )
          ],
        ));
  }
}
