import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/user_model.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';
import 'package:stockfare_mobile/screens/auth_pages/phone_verification.dart';
import 'package:stockfare_mobile/screens/drawer_pages/logout.dart';
import 'package:stockfare_mobile/screens/intro_pages/explore_page.dart';
import 'dart:async';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';

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
    String body = prefs.getString('body');
    bool verified = prefs.getBool('verified');
    if (token != null) {
      User user = User.fromJson(json.decode(body));
      if (verified == false) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Login()));
      } else if (user.firebaseId == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LogoutPage()));
      } else {
        _saveUser(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => BottomNavigationPage()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Login()));
    }
  }
}

_saveUser(context) async {
  final prefs = await SharedPreferences.getInstance();
  String body = prefs.getString('body');
  User user = User.fromJson(json.decode(body));
  SignupNotifier _signupNotifier =
      Provider.of<SignupNotifier>(context, listen: false);
  _signupNotifier.setProfile(
    user.fullname,
    user.phone,
    user.email,
    user.firebaseId,
    user.branchName,
    user.branchAddress,
    user.notificationStatus,
    user.subscriptionPlan,
  );
}
