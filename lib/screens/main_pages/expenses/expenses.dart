import 'package:flutter/material.dart';
import 'package:stockfare_mobile/helpers/sub_helpers.dart';
import 'package:stockfare_mobile/models/expenses-summary.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/expenses_services.dart';

class ExpensesHomePage extends StatefulWidget {
  @override
  _ExpensesHomePageState createState() => _ExpensesHomePageState();
}

class _ExpensesHomePageState extends State<ExpensesHomePage> {
  String _expenses = "expense_made_on";
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
  bool today = false;
  bool week = false;
  bool month = false;
  bool _permission = true;
  List<String> dropdown = [];
  @override
  @override
  void initState() {
    super.initState();
    Subscription().getSubscriptionPlan().then((value) {
      if (value == 'PREMIUM') {
        _expensesSummary = _expensesServices.getExpenseSummary();
        _expensesServices.getExpenseDropdown().then((value) {
          setState(() {
            dropdown.addAll(value);
          });
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
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
            onPressed: () => expensesForm(),
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.black),
        body: _permission == false
            ? Center(
                child: Text(
                    'Your current plan does not support this package. Please upgrade to enjoy.'))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: FutureBuilder<ExpensesSummary>(
                          future: _expensesSummary,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
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
                                              return snapshot.data.weekSummary
                                                  .toString();
                                            } else if (month) {
                                              return snapshot.data.monthSummary
                                                  .toString();
                                            } else {
                                              return snapshot.data.todaySummary
                                                  .toString();
                                            }
                                          }()),
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ));
                            }
                            return CircularProgressIndicator();
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
                          height: 120,
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
                        'RECENT ACTIVITIES',
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                    _listTile('Food', '23/07/2019', 'N125000'),
                    _listTile('Food', '23/07/2019', 'N125000'),
                    _listTile('Food', '23/07/2019', 'N125000')
                  ],
                ),
              ));
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

  _listTile(name, date, amount) => Center(
        child: Container(
          width: 310,
          height: 70,
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
                  Text(name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(amount,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey[800])),
                ],
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey[800]),
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
                      SizedBox(width: 5),
                      Text('Back'),
                      SizedBox(width: 30),
                      Text('RECORD EXPENSES',
                          style: TextStyle(
                              fontSize: 18,
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
                                padding: const EdgeInsets.only(left: 200),
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
                                padding: const EdgeInsets.only(left: 200),
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
                              validator: (input) =>
                                  input.isEmpty ? "Enter Name" : null,
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
                      Container(
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
                                _activitiesServices
                                    .checkForInternet()
                                    .then((value) async {
                                  if (value == true) {
                                    String expensesToSend;
                                    if (_newExpenses == null) {
                                      expensesToSend = _expenses;
                                    } else {
                                      expensesToSend = _newExpenses;
                                    }
                                    setState(() {
                                      _loading = true;
                                    });
                                    dynamic result =
                                        await _expensesServices.createExpenses(
                                            _amount,
                                            _description,
                                            expensesToSend,
                                            "${selectedDate.toLocal()}"
                                                .split(' ')[0]);
                                    if (result == 201) {
                                      setState(() {
                                        _loading = false;
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
