import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/intro_pages/add_product_intro.dart';
import 'package:stockfare_mobile/screens/intro_pages/multiple_product.dart';

class AppBarProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 12),
      child: Container(
        height: 40,
        width: 320,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.red, width: 3)),
        child: Row(
          children: [
            GestureDetector(
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                ),
                child: Center(
                    child: Text(
                  'Add Single Product',
                  style: TextStyle(color: Colors.red),
                )),
              ),
              onTap: () {
                Navigator.of(context).push(_createRoute());
              },
            ),
            SizedBox(
              width: 14,
            ),
            GestureDetector(
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                child: Center(
                    child: Text(
                  'Add Multiple Product',
                  style: TextStyle(color: Colors.white),
                )),
              ),
              onTap: () {
                Navigator.of(context).push(_createRoute1());
              },
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AddProductIntro(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);
      return child;
    },
  );
}

Route _createRoute1() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MultiplePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);
      return child;
    },
  );
}
