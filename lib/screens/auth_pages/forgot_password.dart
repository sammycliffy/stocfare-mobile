import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/auth_pages/new_password.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/auth_services.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String data;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _error;
  AuthServices _authServices = AuthServices();
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
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          body: SafeArea(
            child: Column(children: [
              SizedBox(
                height: 120,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              Center(
                  child: Text(
                'Let\'s help you recover your account',
                style: TextStyle(
                  fontSize: 17,
                ),
              )),
              SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (input) =>
                        input.isEmpty ? "Phone Number or Email" : null,
                    onChanged: (val) => setState(() {
                      data = val;
                    }),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(12),
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2))),
                      hintStyle: TextStyle(
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
                      hintText: 'Phone Number or Email',
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
              ),
              SizedBox(height: 50),
              GestureDetector(
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        'Send Code',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _activitiesServices
                          .checkForInternet()
                          .then((value) async {
                        if (value == true) {
                          DialogBoxes().loading(context);
                          dynamic result =
                              await _authServices.forgotPassword(data);

                          if (result != true) {
                            Navigator.pop(context);
                            setState(() {
                              result == null
                                  ? _error =
                                      'Opps! Error occured, please try again.'
                                  : _error = 'Phone number or email not found.';
                              _displaySnackBar(context);
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewPassword()));
                          }
                        } else {
                          setState(() {
                            _error = 'Check your internet connection';
                            _displaySnackBar(context);
                          });
                        }
                      });
                    }
                  }),
            ]),
          )),
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
