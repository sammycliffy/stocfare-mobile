import 'package:flutter/material.dart';
import 'package:stockfare_mobile/intro_pages/fourth_intro.dart';
import 'package:stockfare_mobile/intro_pages/third_intro.dart';

class MultiplePage extends StatefulWidget {
  @override
  _MultiplePageState createState() => _MultiplePageState();
}

class _MultiplePageState extends State<MultiplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 50),
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
                      Navigator.pop(context);
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ThirdIntro()));
                    },
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 30),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child:
                        Icon(Icons.add_a_photo, color: Colors.grey, size: 70)),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(_createRoute());
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 250, left: 30),
            child: Text(
              'Upload more than one product',
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => FourthIntroPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);
      return child;
    },
  );
}
