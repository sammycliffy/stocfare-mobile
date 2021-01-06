import 'package:flutter/material.dart';
import 'package:stockfare_mobile/helpers/save_user.dart';
import 'package:stockfare_mobile/screens/auth_pages/forgot_password.dart';
import 'package:stockfare_mobile/screens/auth_pages/signup.dart';
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
  DateTime d = DateTime.now();
  var _error;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthServices _auth = AuthServices(); // for login
  ActivitiesServices _activitiesServices =
      ActivitiesServices(); // check for network

  @override
  Widget build(BuildContext context) {
    return Container(
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
              SizedBox(height: 40),
              Center(
                  child: Image.asset('assets/images/login1.png',
                      width: 250, height: 250)),
              SizedBox(height: 20),
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
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(13),
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
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
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(13),
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
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
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                        )),
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                        child: Center(
                          child: Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(20)),
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
                          // DateTime newDate = Jiffy(d).add(days: 13);
                          // print(newDate.isAfter(DateTime.now()));
                          if (_formKey.currentState.validate()) {
                            _activitiesServices
                                .checkForInternet()
                                .then((value) async {
                              if (value == true) {
                                DialogBoxes().loading(context);
                                dynamic result = await _auth
                                    .loginUsernew(
                                      phoneNumber,
                                      password,
                                    )
                                    .timeout(Duration(seconds: 30));

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
                                  SaveUser().setProfileUser(context);
                                }
                              } else {
                                Navigator.pop(context);
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
}
