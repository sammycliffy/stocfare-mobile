import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stockfare_mobile/screens/subscription/starter.dart';

class SuccessRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/product_added.png'),
            Text(
              'Registration',
              style: TextStyle(fontSize: 25, color: Colors.blue[800]),
            ),
            Text(
              'Successfully',
              style: TextStyle(fontSize: 25, color: Colors.blue[800]),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                'Congratulations!!! Welcome to stockfare. You are now ready to automate your inventory management system',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 50,
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
                          child: StarterPage()));
                })
          ],
        ));
  }
}
