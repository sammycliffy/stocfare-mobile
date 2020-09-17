import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';
import 'package:stockfare_mobile/screens/auth_pages/registration_success.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/auth_services.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerification createState() => _PhoneVerification();
}

class _PhoneVerification extends State<PhoneVerification> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthServices _auth = AuthServices();
  bool loading = false;
  String code;
  String _error;

  setPhoneVerification() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('verified', true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login())),
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  'Phone Verification',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
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
                        validator: (val) =>
                            val.length < 6 ? 'Enter valid OTP' : null,
                        onChanged: (val) => setState(() {
                          code = val;
                        }),
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.phone,
                              color: Theme.of(context).accentColor),
                          hintText: 'Enter OTP number',
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
                      height: 60,
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
                              'Continue',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            DialogBoxes().loading(context);

                            dynamic result = await _auth
                                .verifyPhone(code)
                                .timeout(Duration(seconds: 20),
                                    onTimeout: () => null);
                            if (result == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SuccessRegister()));
                              setPhoneVerification();
                            } else {
                              Navigator.pop(context);
                              setState(() {
                                result == null
                                    ? _error =
                                        'Network Error, please try again.'
                                    : _error =
                                        'The code you entered is invalid';
                                _displaySnackBar(context);
                              });
                            }
                          }
                        }),
                    SizedBox(height: 20),
                    InkWell(
                      child: Text('Resend OTP', style: TextStyle(fontSize: 15)),
                      onTap: () async {
                        DialogBoxes().loading(context);
                        dynamic result = await _auth.resendCode();
                        if (result == true) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          setState(() {
                            result == null
                                ? _error = 'Network Error, please try again.'
                                : _error = result.toString();
                            _displaySnackBar(context);
                          });
                        }
                      },
                    ),
                    SizedBox(height: 120),
                  ],
                ),
              )
            ],
          ))),
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
