import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/user_model.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/auth_pages/phone_verification.dart';
import 'package:stockfare_mobile/screens/drawer_pages/logout.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';

class SaveUser {
  saveUser(context) async {
    final prefs = await SharedPreferences.getInstance();
    String body = prefs.getString('body');
    bool verified = prefs.getBool('verified');
    User user = User.fromJson(json.decode(body));
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);

    if (verified == false) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PhoneVerification()));
    } else if (user.firebaseId == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LogoutPage()));
    } else {
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => BottomNavigationPage()));
    }
  }
}
