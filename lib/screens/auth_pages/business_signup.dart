import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/auth_pages/phone_verification.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/loader.dart';
import 'package:stockfare_mobile/services/auth_services.dart';
import 'login.dart';

class BusinessSignupPage extends StatefulWidget {
  @override
  _SignupPage createState() => _SignupPage();
}

class _SignupPage extends State<BusinessSignupPage> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String businessName;
  String businessAddress;
  String businessDescription;
  String businessType;
  String referralCode;
  String _error;
  bool loading = false;
  AuthServices _auth = AuthServices();
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
                        height: 10,
                      ),
                      Center(
                          child: Image.asset('assets/images/logo.png',
                              width: 40, height: 40)),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'Business Signup',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                            'We just need a few information about your business',
                            style: TextStyle(
                              fontSize: 12,
                            )),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                validator: (input) => input.isEmpty
                                    ? 'Enter your Business name'
                                    : null,
                                onChanged: (val) => setState(() {
                                  businessName = val;
                                }),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.create,
                                      color: Theme.of(context).accentColor),
                                  hintText: 'Enter Business name',
                                  filled: true,
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
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                validator: (input) => input.isEmpty
                                    ? 'Enter Business Address'
                                    : null,
                                onChanged: (val) => setState(() {
                                  businessAddress = val;
                                }),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.location_on,
                                      color: Theme.of(context).accentColor),
                                  hintText: 'Enter Business Address',
                                  filled: true,
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
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                validator: (input) => input.isEmpty
                                    ? 'Enter Business Description'
                                    : null,
                                onChanged: (val) => setState(() {
                                  businessDescription = val;
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
                                  prefixIcon: Icon(Icons.mode_comment,
                                      color: Theme.of(context).accentColor),
                                  hintText: 'Briefly describe your business',
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
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                validator: (input) => input.isEmpty
                                    ? 'Enter your business type'
                                    : null,
                                onChanged: (val) => setState(() {
                                  businessType = val;
                                }),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.short_text,
                                      color: Theme.of(context).accentColor),
                                  hintText: 'Enter Businesss type',
                                  filled: true,
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
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.number,
                                onChanged: (val) => setState(() {
                                  referralCode = val;
                                }),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.confirmation_number,
                                      color: Theme.of(context).accentColor),
                                  hintText: 'Referral code (optional)',
                                  filled: true,
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
                              ),
                            ),
                            SizedBox(
                              height: 40,
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
                                      'Signup',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                                onTap: () async {
                                  if (_formkey.currentState.validate()) {
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
                                        String registrationid =
                                            await _auth.getId();

                                        //send the data to the auth registration session
                                        dynamic result =
                                            await _auth.userRegistration(
                                                _signupNotifier.firstName,
                                                _signupNotifier.lastName,
                                                _signupNotifier.email,
                                                _signupNotifier.password,
                                                _signupNotifier.phone,
                                                registrationid,
                                                businessName,
                                                businessAddress,
                                                businessDescription,
                                                businessType,
                                                referralCode ?? '0');
                                        //check if an account already existed
                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                            _error =
                                                'You already have an account with us';
                                            _displaySnackBar(context);
                                          });
                                        } else {
                                          _signupNotifier.setProfile(
                                              result.fullname,
                                              result.phone,
                                              result.email);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhoneVerification()));
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
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already registered?',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
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
