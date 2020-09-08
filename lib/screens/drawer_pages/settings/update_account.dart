import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/auth_services.dart';

class UpdateAccount extends StatefulWidget {
  @override
  _UpdateAccountState createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  String _firstName;
  String _lastName;
  String _email;
  String _phoneNumber;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  String _error;
  AuthServices _authServices = AuthServices();
  ActivitiesServices _activitiesServices = ActivitiesServices();
  @override
  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    List _splitted = _signupNotifier.fullName.split(' ');
    String _initialfirstName = _splitted[0];
    String _initiallastName = _splitted[1];
    return WillPopScope(
      onWillPop: () async => Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationPage())),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Update Account')),
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
                    keyboardType: TextInputType.text,
                    validator: (input) =>
                        input.isEmpty ? 'Enter your last name' : null,
                    onChanged: (val) => setState(() {
                      _firstName = val;
                    }),
                    decoration: InputDecoration(
                      labelText: _initialfirstName,
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
                      prefixIcon: Icon(Icons.person,
                          color: Theme.of(context).accentColor),
                      hintText: 'First Name',
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
                    keyboardType: TextInputType.text,
                    validator: (input) =>
                        input.isEmpty ? 'Enter your last name' : null,
                    onChanged: (val) => setState(() {
                      _lastName = val;
                    }),
                    decoration: InputDecoration(
                      labelText: _initiallastName,
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
                      prefixIcon: Icon(Icons.person,
                          color: Theme.of(context).accentColor),
                      hintText: 'Last Name',
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
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) => !input.contains('@')
                        ? 'Enter a valid email address'
                        : null,
                    onChanged: (val) => setState(() {
                      _email = val;
                    }),
                    decoration: InputDecoration(
                      labelText: _signupNotifier.email,
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
                      prefixIcon: Icon(Icons.alternate_email,
                          color: Theme.of(context).accentColor),
                      hintText: 'Email',
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
                    keyboardType: TextInputType.phone,
                    validator: (input) =>
                        input.length < 11 ? 'Phone must be > 10 Chars' : null,
                    onChanged: (val) => setState(() {
                      _phoneNumber = '+234' + val.substring(1);
                    }),
                    decoration: InputDecoration(
                      labelText: _signupNotifier.phone,
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
                      prefixIcon: Icon(Icons.phone_android,
                          color: Theme.of(context).accentColor),
                      hintText: 'Phone',
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
                          'Update',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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

                            dynamic result = await _authServices
                                .updateDetails(
                                    _firstName, _lastName, _email, _phoneNumber)
                                .timeout(Duration(seconds: 10),
                                    onTimeout: () => null);

                            if (result != 200) {
                              Navigator.pop(context);
                              setState(() {
                                result == null
                                    ? _error =
                                        'Opps! Error occured, please try again.'
                                    : _error = result[0].toString();
                                _displaySnackBar(context);
                              });
                            } else {
                              Navigator.pop(context);
                              setState(() {
                                DialogBoxes().success(context);
                                _signupNotifier.setProfile(
                                  _firstName + ' ' + _lastName,
                                  _phoneNumber,
                                  _email,
                                  _signupNotifier.firebaseId,
                                  _signupNotifier.branchName,
                                  _signupNotifier.branchAddress,
                                  _signupNotifier.notificationStatus,
                                  _signupNotifier.subscriptionPlan,
                                );
                              });
                            }
                          } else {
                            Navigator.pop(context);
                            setState(() {
                              _error =
                                  'Check your internet internet connection';

                              _displaySnackBar(context);
                            });
                          }
                        });
                      }
                    }),
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
