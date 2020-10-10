import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/helpers/save_user.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';
import 'package:stockfare_mobile/screens/intro_pages/explore_page.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  Image currentImage;
  int today = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    super.initState();
    currentImage =
        Image.asset('assets/images/ic_launcher.png', width: 50, height: 50);
    Timer(Duration(seconds: 3), () => checkForFirstInstallation());
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: currentImage,
                ),
                SizedBox(width: 10),
                Text(
                  'Stockfare',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
          Column(children: <Widget>[
            Text(
              'From Contrail Store Ltd.',
              style: TextStyle(
                fontSize: 16,
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

  void checkForFirstInstallation() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('counter') ?? 0;
    prefs.setInt('counter', launchCount + 1);
    if (launchCount == 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => FirstIntro()));
    } else {
      checkForLogin();
    }
  }

  void checkForLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int date = prefs.getInt('date');
    if (token != null) {
      if (date <= today) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Login()));
      } else {
        SaveUser().saveUser(context);
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Login()));
    }
  }
}
