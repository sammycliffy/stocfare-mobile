import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/helpers/sub_helpers.dart';
import 'package:stockfare_mobile/models/expenses-summary.dart';
import 'package:stockfare_mobile/models/loss_model.dart';
import 'package:stockfare_mobile/models/profit.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/analytics/profit_details.dart';
import 'package:stockfare_mobile/screens/subscription/sub_home.dart';
import 'package:stockfare_mobile/services/profit_loss_services.dart';

import 'loss_details.dart';

class ProfitAndLossPage extends StatefulWidget {
  @override
  _ProfitAndLossPageState createState() => _ProfitAndLossPageState();
}

class _ProfitAndLossPageState extends State<ProfitAndLossPage> {
  String paymentMethod = 'Select Expense';
  DateTime selectedDate = DateTime.now();
  bool _isNew = false;
  Future<ExpensesSummary> _profitSummary;
  Future<ExpensesSummary> _lossSummary;
  Future<List<ProfitModel>> _profitList;
  Future<List<LossModel>> _lossList;
  ProfitAndLoss _profitAndLoss = ProfitAndLoss();
  bool _permission = true;
  bool today = false;
  bool week = false;
  bool month = false;
  bool lossToday = false;
  bool lossWeek = false;
  bool lossMonth = false;
  List _profitListName = [];
  List _profitListAmount = [];
  List _profitListQuantity = [];
  List _lossListName = [];
  List _lossListAmount = [];
  List _lossListQuantity = [];

  @override
  void initState() {
    super.initState();
    Subscription().getSubscriptionPlan().then((value) {
      if (value == 'PREMIUM') {
        setState(() {
          _profitSummary = _profitAndLoss.getAllProfit();
          _lossSummary = _profitAndLoss.getAllLoss();
          _profitList = _profitAndLoss.getProfitList();
          _lossList = _profitAndLoss.getLossList();
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
        body: _permission == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    'Your current plan does not support this activity. \nPlease upgrade to enjoy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  )),
                  SizedBox(height: 20),
                  GestureDetector(
                    child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text('Upgrade',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)))),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubscriptionPage())),
                  )
                ],
              )
            : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(height: 10),
                    FutureBuilder<ExpensesSummary>(
                        future: _profitSummary,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            controller.updateValue(
                                snapshot.data.todaySummary.toDouble());
                            controller1.updateValue(
                                snapshot.data.weekSummary.toDouble());
                            controller2.updateValue(
                                snapshot.data.monthSummary.toDouble());
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Text(
                                    'Profit',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      height: 120,
                                      width: 330,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                                  return controller1.text;
                                                } else if (month) {
                                                  return controller2.text;
                                                } else {
                                                  return controller.text;
                                                }
                                              }()),
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: ExpansionTile(
                                    key: PageStorageKey('myScrollable'),
                                    title: Text(
                                      "View All",
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.green),
                                    ),
                                    children: <Widget>[
                                      FutureBuilder<List<ProfitModel>>(
                                          future: _profitList,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              _profitListName.clear();
                                              _profitListAmount.clear();
                                              _profitListQuantity.clear();

                                              print(snapshot.data.map((e) {
                                                _profitListName
                                                    .add(e.productInfo[0].name);
                                                _profitListAmount.add(
                                                    e.productInfo[0].amount);
                                                _profitListQuantity.add(
                                                    e.productInfo[0].quantity);
                                              }));
                                              return Container(
                                                height: 150,
                                                child: ListView.builder(
                                                    key: PageStorageKey(
                                                        'myScrollable'),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            index) {
                                                      return GestureDetector(
                                                        child: ListTile(
                                                          title: Text(
                                                              _profitListName[
                                                                  index],
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          trailing: Text(
                                                            _profitListAmount[
                                                                    index]
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ProfitDetails(
                                                                            productIndex:
                                                                                index,
                                                                            profitList:
                                                                                snapshot.data,
                                                                          )));
                                                        },
                                                      );
                                                    },
                                                    itemCount:
                                                        _profitListName.length),
                                              );
                                            }
                                            return CircularProgressIndicator();
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
                    SizedBox(height: 10),
                    FutureBuilder<ExpensesSummary>(
                        future: _lossSummary,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            controller.updateValue(
                                snapshot.data.todaySummary.toDouble());
                            controller1.updateValue(
                                snapshot.data.weekSummary.toDouble());
                            controller2.updateValue(
                                snapshot.data.monthSummary.toDouble());
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Text(
                                    'Loss',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      height: 120,
                                      width: 330,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                                  return controller1.text;
                                                } else if (month) {
                                                  return controller2.text;
                                                } else {
                                                  return controller.text;
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
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: ExpansionTile(
                                    key: PageStorageKey('myScrollable'),
                                    title: Text(
                                      "View All",
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.green),
                                    ),
                                    children: <Widget>[
                                      FutureBuilder<List<LossModel>>(
                                          future: _lossList,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              _lossListName.clear();
                                              _lossListAmount.clear();
                                              _lossListQuantity.clear();
                                              print(snapshot.data.map((e) {
                                                _lossListName
                                                    .add(e.productInfo[0].name);
                                                _lossListAmount.add(
                                                    e.productInfo[0].amount);
                                                _lossListQuantity.add(
                                                    e.productInfo[0].quantity);
                                              }));
                                              return Container(
                                                height: 150,
                                                child: ListView.builder(
                                                    key: PageStorageKey(
                                                        'myScrollable'),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            index) {
                                                      return GestureDetector(
                                                          child: ListTile(
                                                            title: Text(
                                                                _lossListName[
                                                                    index],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            trailing: Text(
                                                              _lossListAmount[
                                                                  index],
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            LossDetails(
                                                                              productIndex: index,
                                                                              profitList: snapshot.data,
                                                                            )));
                                                          });
                                                    },
                                                    itemCount:
                                                        _lossListName.length),
                                              );
                                            }
                                            return CircularProgressIndicator();
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
                    SizedBox(height: 50),
                  ])));
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
}