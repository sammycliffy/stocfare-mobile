import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/auth_pages/forgot_password.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/auth_services.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPassword createState() => _NewPassword();
}

class _NewPassword extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  AuthServices _authServices = AuthServices();
  String password;
  String password1;
  String verificationCode;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;
  ActivitiesServices _activitiesServices = ActivitiesServices();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ForgotPassword())),
      child: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
              Colors.red[300],
              Colors.white,
            ],
                stops: [
              0.0,
              1.0
            ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                tileMode: TileMode.repeated)),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    'Password Reset',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text('Enter the 6 digit that was sent to your phone',
                      style: TextStyle(
                        fontSize: 14,
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (input) =>
                              input.isEmpty ? "Enter OTP" : null,
                          onChanged: (val) => setState(() {
                            verificationCode = val;
                          }),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.all(12),
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            hintText: 'Enter OTP',
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
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input.isEmpty ? "New password" : null,
                          onChanged: (val) => setState(() {
                            password = val;
                          }),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
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
                            hintText: 'New password',
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
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input.isEmpty ? "Confirm password" : null,
                          onChanged: (val) => setState(() {
                            password1 = val;
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
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Confirm password',
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
                      SizedBox(
                        height: 60,
                      ),
                      GestureDetector(
                          child: Center(
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                'Update',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              if (password != password1) {
                                _error = 'Passwords do not match';
                                _displaySnackBar(context);
                              } else {
                                _activitiesServices
                                    .checkForInternet()
                                    .then((value) async {
                                  if (value == true) {
                                    DialogBoxes().loading(context);
                                    dynamic result = await _authServices
                                        .verifyPasswordCode(
                                            verificationCode, password)
                                        .timeout(Duration(seconds: 10),
                                            onTimeout: () => null);

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
                                      DialogBoxes().success(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    }
                                  } else {
                                    setState(() {
                                      _error = 'Check your internet Connection';

                                      _displaySnackBar(context);
                                    });
                                  }
                                });
                              }
                            }
                          }),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Back to',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            child: Text(
                              'Resend',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
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
        ),
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
