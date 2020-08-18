import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/auth_pages/new_password.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/auth_services.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String data;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;
  AuthServices _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Image.asset('assets/images/logo.png',
                    width: 40, height: 40)),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
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
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: (input) =>
                    input.isEmpty ? "Enter your password" : null,
                onChanged: (val) => setState(() {
                  data = val;
                }),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  hintStyle: TextStyle(
                      color: Theme.of(context).focusColor.withOpacity(0.7)),
                  hintText: 'Phone Number or Email',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.5))),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
                child: Center(
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Send Code',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                onTap: () {
                  DialogBoxes().loading(context);
                  _authServices.forgotPassword(data).then((value) {
                    if (value == false) {
                      Navigator.pop(context);
                      setState(() {
                        _error =
                            'Phone number or Email does not belong to any account';
                        _displaySnackBar(context);
                      });
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewPassword()));
                    }
                  });
                }),
          ]),
        ));
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
