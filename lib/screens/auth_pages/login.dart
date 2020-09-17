import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/user_model.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/auth_pages/forgot_password.dart';
import 'package:stockfare_mobile/screens/auth_pages/phone_verification.dart';
import 'package:stockfare_mobile/screens/auth_pages/signup.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/auth_services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNumber;
  String password;
  var _error;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthServices _auth = AuthServices(); // for login
  ActivitiesServices _activitiesServices =
      ActivitiesServices(); // check for network

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Image.asset('assets/images/logo.png',
                    width: 40, height: 40)),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text('Secure login to your stockfare_mobile app',
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (input) => input.length < 10
                          ? 'Enter a valid phone number'
                          : null,
                      onChanged: (val) => setState(() {
                        phoneNumber = '+234' + val.substring(1);
                      }),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.phone_android,
                            color: Theme.of(context).accentColor),
                        hintText: 'Enter phone number',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      validator: (input) =>
                          input.isEmpty ? "Enter your password" : null,
                      onChanged: (val) => setState(() {
                        password = val;
                      }),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.lock_open,
                            color: Theme.of(context).accentColor),
                        hintText: 'Enter password',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: InkWell(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                      )),
                  SizedBox(
                    height: 100,
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
                            'Login',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          _activitiesServices
                              .checkForInternet()
                              .then((value) async {
                            if (value == true) {
                              DialogBoxes().loading(context);
                              dynamic result = await _auth.loginUsernew(
                                phoneNumber,
                                password,
                              );

                              if (result != true) {
                                Navigator.pop(context);
                                setState(() {
                                  result == null
                                      ? _error =
                                          'Opps! Error occured, please try again.'
                                      : _error = result;
                                  _displaySnackBar(context);
                                });
                              } else {
                                Navigator.pop(context);
                                _saveUser(context);
                              }
                            } else {
                              setState(() {
                                _error =
                                    'Please check your internet connection';

                                _displaySnackBar(context);
                              });
                            }
                          });
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New to Stockfare ?',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        child: Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          _error.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _saveUser(context) async {
    final prefs = await SharedPreferences.getInstance();
    String body = prefs.getString('body');
    dynamic user = User.fromJson(json.decode(body));
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

    if (user.verified == false) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PhoneVerification()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationPage()));
    }
  }
}
