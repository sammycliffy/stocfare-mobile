import 'package:flutter/material.dart';
import 'package:stockfare_mobile/intro_pages/third_intro.dart';

class SecondIntro extends StatelessWidget {
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
                'Explore the Power of ',
                style: TextStyle(fontSize: 16, color: Colors.grey[900]),
              ),
              Text('Stockfare App',
                  style: TextStyle(fontSize: 16, color: Colors.grey[900])),
              SizedBox(
                height: 40,
              ),
              Text(
                'Discover how Stockfare App works ',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              Text('in 4 easy steps',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              SizedBox(
                height: 80,
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
                  Navigator.of(context).push(_createRoute());
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text('Add a product',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800])),
              SizedBox(
                height: 80,
              ),
              Text('To check how this works Add a',
                  style: TextStyle(fontSize: 14, color: Colors.grey[800])),
              Text('in less than a minute',
                  style: TextStyle(fontSize: 14, color: Colors.grey[800])),
              SizedBox(
                height: 90,
              ),
            ],
          ),
        ));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ThirdIntro(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(4.0, 0.2);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
