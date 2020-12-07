import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/helpers/sub_helpers.dart';
import 'package:stockfare_mobile/models/all_expenses_model.dart';
import 'package:stockfare_mobile/models/expenses-summary.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/expenses_services.dart';

class ExpensesHomePage extends StatefulWidget {
  @override
  _ExpensesHomePageState createState() => _ExpensesHomePageState();
}

class _ExpensesHomePageState extends State<ExpensesHomePage> {
  String _expenses = "transportation";
  DateTime selectedDate = DateTime.now();
  bool _isNew = false;
  ExpensesServices _expensesServices = ExpensesServices();
  ActivitiesServices _activitiesServices = ActivitiesServices();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;
  String _amount;
  String _description;
  bool _loading = false;
  String _newExpenses;
  Future<ExpensesSummary> _expensesSummary;
  Future<List<GetAllExpenses>> _getallExpenses;
  bool today = false;
  bool week = false;
  bool month = false;
  bool _permission = true;
  List<String> dropdown = [];
  List<String> _expensesAmount = [];
  List<String> _expensesDate = [];
  List<String> _expensesDescription = [];
  List<String> _expensesName = [];
  bool _permissionError = false;
  String _errorMessage = '';
  bool isNetwork = true;

  @override
  void initState() {
    super.initState();

    Subscription().getSubscriptionPlan().then((value) {
      if (value == 'PREMIUM') {
        _activitiesServices.checkForInternet().then((value) {
          if (value == true) {
            setState(() {
              _expensesServices.reOccuringExpenses();
              _expensesServices.getExpenseDropdown();
            });
            _expensesServices.getExpenseDropdown().then((value) {
              dropdown.addAll(value);
            }).catchError((e) {
              print('${e.toString()} this is the error message');
              setState(() {
                _permissionError = true;
                _errorMessage = e ?? 'This is wrong';
              });
            });
          } else {
            isNetwork = false;
          }
        });
      } else {
        setState(() {
          _permission = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    var controller = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    var controller1 = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    var controller2 = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    var controller3 = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
          onPressed: () => (() {
                if (_permission == false) {
                  return DialogBoxes().invalidSubscription(context);
                } else {
                  return expensesForm();
                }
              }()),
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.black),
      body: isNetwork == false
          ? Center(
              child: Text(
              'App is Offline',
              style: TextStyle(fontSize: 18),
            ))
          : _permission == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 20),
                    Center(
                      child: Container(
                          height: 120,
                          width: 330,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _container('Today', 1),
                                    _container('Week', 2),
                                    _container('Month', 3)
                                  ]),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25.0, top: 10),
                                child: Text(
                                  (() {
                                    if (week) {
                                      return '-${controller1.text}';
                                    } else if (month) {
                                      return '-${controller2.text}';
                                    } else {
                                      return '-${controller.text}';
                                    }
                                  }()),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Text(
                        'QUICK CATEGORIES',
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Container(
                          padding: const EdgeInsets.only(top: 20),
                          width: 350,
                          height: 110,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.grey[200]),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _categories('Fuel'),
                              SizedBox(height: 5),
                              _categories('Food'),
                              SizedBox(height: 5),
                              _categories('Transport'),
                              SizedBox(height: 5),
                              _categories('Clothes')
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35.0, top: 10, bottom: 10),
                      child: Text(
                        'RECENT EXPENSES',
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                    Center(child: Text('No Expenses')),
                    SizedBox(height: 150),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 20),
                    Center(
                      child: FutureBuilder<ExpensesSummary>(
                          future: _expensesServices.getExpenseSummary(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              controller.updateValue(
                                  snapshot.data.todaySummary.toDouble());
                              controller1.updateValue(
                                  snapshot.data.weekSummary.toDouble());
                              controller2.updateValue(
                                  snapshot.data.monthSummary.toDouble());
                              return Container(
                                  height: 120,
                                  width: 330,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            _container('Today', 1),
                                            _container('Week', 2),
                                            _container('Month', 3)
                                          ]),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, top: 10),
                                        child: Text(
                                          (() {
                                            if (week) {
                                              return '-${controller1.text}';
                                            } else if (month) {
                                              return '-${controller2.text}';
                                            } else {
                                              return '-${controller.text}';
                                            }
                                          }()),
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      )
                                    ],
                                  ));
                            }
                            return Column(
                              children: [LinearProgressIndicator()],
                            );
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Text(
                        'QUICK CATEGORIES',
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Container(
                          padding: const EdgeInsets.only(top: 20),
                          width: 350,
                          height: 110,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.grey[200]),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _categories('Fuel'),
                              SizedBox(height: 5),
                              _categories('Food'),
                              SizedBox(height: 5),
                              _categories('Transport'),
                              SizedBox(height: 5),
                              _categories('Clothes')
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35.0, top: 10, bottom: 10),
                      child: Text(
                        'RECENT EXPENSES',
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                    FutureBuilder<List<GetAllExpenses>>(
                        future: _expensesServices.getAllExpenses(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            _expensesName.clear();
                            _expensesAmount.clear();
                            _expensesDate.clear();
                            _expensesDescription.clear();
                            print(snapshot.data.map((value) {
                              _expensesName.add(value.expenseMadeOnName);
                              _expensesAmount.add(value.amount);
                              _expensesDate.add(value.date);
                              _expensesDescription.add(value.note);
                            }));

                            return Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _expensesName.length,
                                  itemBuilder: (context, index) {
                                    controller3.updateValue(
                                        double.parse(_expensesAmount[index]));
                                    return _listTile(
                                        _expensesName[index],
                                        Jiffy(_expensesDate[index])
                                            .format('MMMM do yyyy'),
                                        controller3.text,
                                        _expensesDescription[index]);
                                  }),
                            );
                          } else {
                            return SizedBox();
                          }
                        })
                  ],
                ),
    );
  }

  _container(day, route) => GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          height: 30,
          width: 80,
          child: Center(
              child: Text(day,
                  style: TextStyle(color: Theme.of(context).primaryColor))),
        ),
        onTap: () {
          switch (route) {
            case 1:
              {
                setState(() {
                  today = true;
                  week = false;
                  month = false;
                });
              }
              break;
            case 2:
              {
                setState(() {
                  week = true;
                  today = false;
                  month = false;
                });
              }
              break;
            case 3:
              {
                setState(() {
                  month = true;
                  week = false;
                  today = false;
                });
              }
              break;
          }
        },
      );

  _listTile(name, date, amount, description) => Center(
        child: Container(
          width: 310,
          height: 80,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey[300]))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name ?? 'None',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  Text(amount,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey[800])),
                ],
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey[800]),
              ),
              Text(
                description,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );

  _categories(name) => Column(
        children: [
          Container(
            child: Container(
              width: 60,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey[200]),
              child: Icon(Icons.attach_money),
            ),
          ),
          Text(name,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16)),
        ],
      );

  expensesForm() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        SignupNotifier _signupNotifier =
            Provider.of<SignupNotifier>(context, listen: false);
        var controller4 = new MoneyMaskedTextController(
            decimalSeparator: '.',
            thousandSeparator: ',',
            leftSymbol: ' ${_signupNotifier.country} ');
        return StatefulBuilder(
          builder: (context, setState) {
            Future<Null> _selectDate(BuildContext context) async {
              final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101));
              if (picked != null && picked != selectedDate)
                setState(() {
                  selectedDate = picked;
                });
            }

            return AlertDialog(
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 2),
                      Text('Back'),
                      SizedBox(width: 20),
                      Text('RECORD EXPENSES',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor))
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(height: 10),
                      Container(
                        width: 370,
                        child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  value: _expenses,
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 4,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _expenses = newValue;
                                      _error = null;
                                    });
                                  },
                                  items: dropdown.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(fontSize: 16)),
                                    );
                                  }).toList(),
                                ))),
                      ),
                      _isNew
                          ? GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 150),
                                child: Container(
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text('Close',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _isNew = false;
                                });
                              })
                          : GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 150),
                                child: Container(
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text('Add new',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _isNew = true;
                                });
                              }),
                      SizedBox(height: 10),
                      _isNew
                          ? TextFormField(
                              keyboardType: TextInputType.text,
                              onChanged: (val) => setState(() {
                                _newExpenses = val;
                              }),
                              decoration: InputDecoration(
                                labelText: 'Name',
                                contentPadding: EdgeInsets.all(12),
                                labelStyle: TextStyle(color: Colors.grey[600]),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7)),
                                hintText: 'Food',
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
                            )
                          : SizedBox(),
                      Text(
                        _error ?? '',
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      SizedBox(height: 3),
                      TextFormField(
                        controller: controller4,
                        keyboardType: TextInputType.number,
                        validator: (input) =>
                            input.isEmpty ? "Enter Amount" : null,
                        onChanged: (val) => setState(() {
                          _amount = val;
                        }),
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          contentPadding: EdgeInsets.all(12),
                          labelStyle: TextStyle(color: Colors.grey[600]),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          hintText: '12,000.00',
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
                      SizedBox(height: 20),
                      GestureDetector(
                        child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400]),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${selectedDate.toLocal()}".split(' ')[0],
                                    style: TextStyle(color: Colors.grey[600])),
                                IconButton(
                                  icon: Icon(Icons.date_range,
                                      color: Theme.of(context).primaryColor),
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                )
                              ],
                            )),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (input) =>
                            input.isEmpty ? "Description" : null,
                        onChanged: (val) => setState(() {
                          _description = val;
                        }),
                        decoration: InputDecoration(
                          labelText: 'Description',
                          contentPadding: EdgeInsets.all(12),
                          labelStyle: TextStyle(color: Colors.grey[600]),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          hintText: 'Description',
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
                      SizedBox(height: 10),
                      _loading
                          ? CircularProgressIndicator()
                          : InkWell(
                              child: Container(
                                width: 200,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text('Done',
                                        style: TextStyle(color: Colors.white))),
                              ),
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  _activitiesServices
                                      .checkForInternet()
                                      .then((value) async {
                                    if (value == true) {
                                      _expensesServices
                                          .refreshgetExpensesAndSummary();
                                      String expensesToSend;
                                      if (_newExpenses == null) {
                                        expensesToSend = _expenses;
                                      } else {
                                        expensesToSend = _newExpenses;
                                      }
                                      setState(() {
                                        _loading = true;
                                      });
                                      dynamic result = await _expensesServices
                                          .createExpenses(
                                              controller4.numberValue
                                                  .round()
                                                  .toString(),
                                              _description,
                                              expensesToSend,
                                              "${selectedDate.toLocal()}"
                                                  .split(' ')[0]);
                                      if (result == 201) {
                                        setState(() {
                                          _loading = false;
                                        });
                                        Navigator.pop(context);
                                        rebuildPage();
                                      } else {
                                        setState(() {
                                          _loading = false;
                                          _error = result;
                                        });
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      setState(() {
                                        _error =
                                            'Please check your internet connection';

                                        _displaySnackBar(context);
                                      });
                                    }
                                  });
                                }
                              },
                            )
                    ]),
                  )
                ],
              )),
            );
          },
        );
      },
    );
  }

  rebuildPage() {
    setState(() {
      _expensesSummary = _expensesServices.getExpenseSummary();
      _getallExpenses = _expensesServices.getAllExpenses();
    });
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
