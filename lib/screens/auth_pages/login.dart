import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/auth_pages/registration_success.dart';
import 'package:stockfare_mobile/screens/auth_pages/signup.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/loader.dart';
import 'package:stockfare_mobile/services/auth_services.dart';
import 'package:stockfare_mobile/services/product_services.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNumber;
  String password;
  String _error;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthServices _auth = AuthServices();
  ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier = Provider.of<SignupNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: loading
                ? Loading()
                : Column(
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
                        child: Text('Secure login to your stockfare app',
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
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
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
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
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
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                validator: (input) => input.isEmpty
                                    ? "Enter your password"
                                    : null,
                                onChanged: (val) => setState(() {
                                  password = val;
                                }),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
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
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));
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
                                        border: Border.all(
                                            color: Colors.red, width: 3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                        child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                                onTap: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });

                                    try {
                                      final result =
                                          await InternetAddress.lookup(
                                              'google.com');
                                      if (result.isNotEmpty &&
                                          result[0].rawAddress.isNotEmpty) {
                                        print('connected');
                                        String _registrationid =
                                            await _auth.getId();
                                        dynamic result =
                                            await _auth.loginUsernew(
                                                phoneNumber,
                                                password,
                                                _registrationid);

                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                            _error =
                                                'Could not sign in with those credentials';
                                            _displaySnackBar(context);
                                          });
                                        } else {
                                          //This will set the profile data for the notifier so that it can move between pages
                                          _signupNotifier.setProfile(
                                              result.fullname,
                                              result.phone,
                                              result.email);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavigationPage()));
                                        }
                                      }
                                    } on SocketException catch (_) {
                                      print('not connected');
                                      setState(() {
                                        loading = false;
                                        _error =
                                            'Check your internet connection';
                                        _displaySnackBar(context);
                                      });
                                    }
                                  }
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'New to Stockfare?',
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
                                            builder: (context) =>
                                                SignupPage()));
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
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          _error,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
