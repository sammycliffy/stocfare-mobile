import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/helpers/save_user.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';
import 'package:stockfare_mobile/screens/intro_pages/explore_page.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/app_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  Image currentImage;
  int today = DateTime.now().millisecondsSinceEpoch;
  ActivitiesServices _activityServices = ActivitiesServices();

  @override
  void initState() {
    super.initState();
    currentImage =
        Image.asset('assets/images/log.jpeg', width: 200, height: 200);
    _activityServices.checkForInternet().then((value) {
      if (value == true) {
        _checkAppVersion(context);
      } else {
        checkForFirstInstallation();
      }
    });
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  currentImage,
                ]),
          ),
          Center(
            child: Column(children: <Widget>[
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
          ),
        ],
      ),
    );
  }

  _checkAppVersion(context) {
    AppServices _appServices = AppServices();
    String _appVersionNumber = '45';
    _appServices.getAppVersion().then((value) {
      if (value == null) {
        checkForFirstInstallation();
      } else if (_appVersionNumber != value) {
        DialogBoxes().upgrader(context);
      } else {
        checkForFirstInstallation();
      }
    });
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
