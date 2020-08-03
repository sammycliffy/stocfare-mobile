import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/auth_services.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String oldPassword;
  String newPassword1;
  String newPassword2;
  String _error;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthServices _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Change Password')),
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (input) =>
                        input.isEmpty ? 'Password must not be empty' : null,
                    onChanged: (val) => setState(() {
                      oldPassword = val;
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
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.lock_open,
                          color: Theme.of(context).accentColor),
                      hintText: 'Old Password',
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    validator: (input) =>
                        input.length < 6 ? 'Password must be > 6 Chars' : null,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    onChanged: (val) => setState(() {
                      newPassword1 = val;
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
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.lock_open,
                          color: Theme.of(context).accentColor),
                      hintText: 'New Password',
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    validator: (input) =>
                        input.length < 6 ? 'Password must be > 6 Chars' : null,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    onChanged: (val) => setState(() {
                      newPassword2 = val;
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
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.lock_open,
                          color: Theme.of(context).accentColor),
                      hintText: 'Confirm Password',
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
                SizedBox(height: 20),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    child: Center(
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(color: Colors.red, width: 3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          'Change Password',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        if (newPassword1 != newPassword2) {
                          setState(() {
                            _error = 'Password does not match';
                            _displaySnackBar(context);
                          });
                        } else {
                          _authServices
                              .updatePassword(oldPassword, newPassword1)
                              .then((value) {
                            if (value == false) {
                              setState(() {
                                _error = 'The old password is not correct';
                                _displaySnackBar(context);
                              });
                            } else {
                              setState(() {
                                DialogBoxes().success(context);
                              });
                            }
                          });
                        }
                      }
                    }),
              ],
            )));
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
