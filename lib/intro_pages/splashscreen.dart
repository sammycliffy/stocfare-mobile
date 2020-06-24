import 'package:flutter/material.dart';
import 'dart:async';

import 'package:stockfare_mobile/intro_pages/first_into.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  Image currentImage;

  @override
  void initState() {
    super.initState();
    currentImage = Image.asset('assets/images/logo.png', width: 50, height: 50);
    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => FirstIntro())));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(currentImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Center(
              child: currentImage,
            ),
          ),
          Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 90,
              ),
              child: Text('from'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 110),
              child: Container(
                width: 8,
                height: 8,
                color: Colors.red,
              ),
            ),
            Text(
              'Contrail Store',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            )
          ]),
        ],
      ),
    );
  }
}
