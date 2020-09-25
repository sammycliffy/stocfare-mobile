import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class CurrentBranch extends StatefulWidget {
  @override
  _CurrentBranchState createState() => _CurrentBranchState();
}

class _CurrentBranchState extends State<CurrentBranch> {
  ProductServices _productServices = ProductServices();
  String branchName;
  String branchAddress;
  bool isInstructionView = false;
  String _error;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    isInstructionView = Global.shared.isInstructionView;
  }

  @override
  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier = Provider.of<SignupNotifier>(context);
    print(_signupNotifier.notificationStatus.toString() + 'this is it');
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Update Current Branch')),
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
                        input.isEmpty ? 'Branch Name can not be empty' : null,
                    onChanged: (val) => setState(() {
                      branchName = val;
                    }),
                    decoration: InputDecoration(
                      labelText: _signupNotifier.branchName,
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
                      hintText: 'Branch Name',
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
                    validator: (input) => input.isEmpty
                        ? 'Branch Address can not be empty'
                        : null,
                    onChanged: (val) => setState(() {
                      branchAddress = val;
                    }),
                    decoration: InputDecoration(
                      labelText: _signupNotifier.branchAddress,
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
                      hintText: 'Branch Address',
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
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    child: Switch(
                      value: isInstructionView,
                      onChanged: (bool isOn) {
                        print(isOn);
                        setState(() {
                          isInstructionView = isOn;
                          Global.shared.isInstructionView = isOn;
                          isOn = !isOn;
                          print(isInstructionView);
                        });
                      },
                      activeColor: Colors.blue,
                      inactiveTrackColor: Colors.grey,
                      inactiveThumbColor: Colors.grey,
                    ),
                  ),
                  Text(
                    'Do you want to be notified on sales?',
                    style: TextStyle(fontSize: 17),
                  )
                ]),
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
                          'Update',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        DialogBoxes().loading(context);
                        dynamic result = await _productServices
                            .updateBranch(
                                branchName, branchAddress, isInstructionView)
                            .timeout(Duration(seconds: 10),
                                onTimeout: () => null);

                        if (result != true) {
                          Navigator.pop(context);
                          setState(() {
                            result == null
                                ? _error =
                                    'Opps! Error occured, please try again.'
                                : _error = result.toString();
                            _displaySnackBar(context);
                          });
                        } else {
                          Navigator.pop(context);
                          DialogBoxes().success(context);
                          setState(() {
                            _signupNotifier.setProfile(
                                _signupNotifier.fullName,
                                _signupNotifier.phone,
                                _signupNotifier.email,
                                _signupNotifier.firebaseId,
                                branchName,
                                branchAddress,
                                isInstructionView,
                                _signupNotifier.subscriptionPlan,
                                _signupNotifier.firebaseCustomerId);
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

class Global {
  static final shared = Global();
  bool isInstructionView = false;
}
