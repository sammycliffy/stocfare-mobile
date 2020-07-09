import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';

class SuccessSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/product_added.png'),
            Text(
              'Subscription',
              style: TextStyle(fontSize: 25, color: Colors.blue[800]),
            ),
            Text(
              'Successful',
              style: TextStyle(fontSize: 25, color: Colors.blue[800]),
            ),
            SizedBox(
              height: 150,
            ),
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
                      'Continue',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: BottomNavigationPage()));
                })
          ],
        ));
  }
}
