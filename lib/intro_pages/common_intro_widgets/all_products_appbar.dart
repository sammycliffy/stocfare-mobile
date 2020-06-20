import 'package:flutter/material.dart';
import 'package:stockfare_mobile/intro_pages/all_products.dart';
import 'package:stockfare_mobile/intro_pages/checkout.dart';

class AppBarAllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 12),
      child: Column(children: [
        Container(
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
                    'All Products',
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
                    'Checkout',
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
        Padding(
          padding: const EdgeInsets.only(left: 280),
          child: Row(
            children: [
              Icon(Icons.shopping_basket, size: 40),
              SizedBox(width: 5),
              Text(
                '24',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AllProductPage(),
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
    pageBuilder: (context, animation, secondaryAnimation) => CheckoutPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);
      return child;
    },
  );
}
