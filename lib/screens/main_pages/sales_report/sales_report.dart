import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/sales_services.dart';

class SalesReportPage extends StatefulWidget {
  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  ActivitiesServices _activitiesServices = ActivitiesServices();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool startDateBool = false;
  bool endDateBool = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;
  SalesServices _salesServices = SalesServices();
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate)
      setState(() {
        startDateBool = true;
        startDate = picked;
      });
  }

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != endDate)
      setState(() {
        endDateBool = true;
        endDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
            Colors.red[200],
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
          appBar: AppBar(
            title: Text(
              'Sales Report',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Theme.of(context).primaryColor,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _signupNotifier.branchName,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _signupNotifier.branchAddress,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          height: 60,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey[300], width: 2)),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: Colors.blue, size: 30),
                              Container(width: 10),
                              startDateBool
                                  ? Text(
                                      "${startDate.toLocal()}".split(' ')[0],
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : Text('Start Date',
                                      style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),
                        onTap: () {
                          _selectDate(context);
                        }),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: 60,
                        width: 160,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey[300], width: 2)),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today,
                                color: Colors.blue, size: 30),
                            Container(width: 10),
                            endDateBool
                                ? Text(
                                    "${endDate.toLocal()}".split(' ')[0],
                                    style: TextStyle(fontSize: 20),
                                  )
                                : Text('End Date',
                                    style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                      onTap: () {
                        _selectEndDate(context);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 100),
              GestureDetector(
                child: Container(
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(
                    'Request',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ),
                onTap: () async {
                  _activitiesServices.checkForInternet().then((value) async {
                    if (value == true) {
                      if (startDateBool == false || endDateBool == false) {
                        setState(() {
                          _error = 'Start date and End date cannot be empty';
                          _displaySnackBar(context);
                        });
                      } else if (startDate.microsecondsSinceEpoch >
                          endDate.microsecondsSinceEpoch) {
                        setState(() {
                          _error = 'Start date cannot be greater than End date';
                          _displaySnackBar(context);
                        });
                      } else {
                        DialogBoxes().loading(context);
                        dynamic result = await _salesServices.getSalesReport(
                            (startDate.toUtc().millisecondsSinceEpoch / 1000)
                                .round(),
                            (endDate.toUtc().millisecondsSinceEpoch / 1000)
                                .round(),
                            _signupNotifier.email);

                        if (result == 200) {
                          Navigator.pop(context);
                          setState(() {
                            _error =
                                'Your sales report has been sent to your email';
                            _displaySnackBarSuccess(context);
                          });
                        } else {
                          Navigator.pop(context);
                          setState(() {
                            _error = '$result';
                            _displaySnackBar(context);
                          });
                        }
                      }
                    } else {
                      setState(() {
                        _error = 'Check your Internet Connection';
                        _displaySnackBar(context);
                      });
                    }
                  });
                },
              ),
            ],
          )),
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

  _displaySnackBarSuccess(BuildContext context) {
    final snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.green,
        content: Text(
          _error.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
