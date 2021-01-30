import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/accounting_services.dart';
import 'package:stockfare_mobile/services/activities_services.dart';

class CashFlow extends StatefulWidget {
  @override
  _CashFlowState createState() => _CashFlowState();
}

class _CashFlowState extends State<CashFlow> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AccountingServices _accountingServices = AccountingServices();
  ActivitiesServices _activitiesServices = ActivitiesServices();
  String _error = '';
  bool preview = true;
  var year = 0;
  var cashAtBeginingOfYear = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var otherOperationReceipt = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var customer = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var inventory = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var administrativeExpenses = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var wagesSalaryExpenses = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var interest = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var incomeTaxes = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var otherOperations = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  double netCashFlowOperations = 0;
  var salePropertyAndEquipment = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var collectionOfPrincipalOnLoans = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var saleOfInvestmentSecurities = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var otherReturns = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var purchaseOfPropertyandEquipment = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var makingLoanstoOtherEntities = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var purchaseOfInvestmentSecurities = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var otherInvestments = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  double netCashInvestment = 0;
  var insuranceSupplies = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var borrowing = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var otherFinancialIncomeCash = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var repurchaseOfStock = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var dividends = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var repaymentOfLoans = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var otherFinancialOutgoingCash = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  double netCashFlowFinancing = 0;
  double cashAtEndOfYear = 0;

  @override
  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);

    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
            Colors.red[100],
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
          appBar: AppBar(title: Text('Cash Flow')),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Cash Flow Statement for ',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '[${_signupNotifier.branchName}]',
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'For the Year                                         ',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        onChanged: (val) => setState(() {
                          year = int.parse(val);
                        }),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Cash at the Begining of the year',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: cashAtBeginingOfYear,
                        decoration: InputDecoration(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  width: 360,
                  height: 750,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 180),
                        child: Container(
                          width: 130,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              'OPERATIONS',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 170),
                        child: Text(
                          'Cash Receipt from:',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: 350,
                        height: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]),
                            borderRadius: BorderRadius.circular(9)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Customer                                ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: customer,
                                    decoration:
                                        InputDecoration(hintText: 'N0.00'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Other Operations                   ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: otherOperationReceipt,
                                    decoration:
                                        InputDecoration(hintText: 'N0.00'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 130),
                        child: Text(
                          'Cash Paid for: ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 300,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]),
                            borderRadius: BorderRadius.circular(9)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Cash paid for Inventory         ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: inventory,
                                    decoration:
                                        InputDecoration(hintText: 'N0.00'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'General operating & \nAdministrative expenses',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(width: 23),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: administrativeExpenses,
                                    decoration:
                                        InputDecoration(hintText: 'N0.00'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Wages/Salary Expenses        ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: wagesSalaryExpenses,
                                    decoration:
                                        InputDecoration(hintText: 'N0.00'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Interest                                   ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: interest,
                                    decoration:
                                        InputDecoration(hintText: 'N0.00'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Income Taxes                         ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: incomeTaxes,
                                    decoration:
                                        InputDecoration(hintText: 'N0.00'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Net Cash Flow from \noperations',
                            style: TextStyle(fontSize: 17, color: Colors.green),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            width: 100,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText:
                                      'N ' + netCashFlowOperations.toString()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                investingActivities(),
                SizedBox(height: 50),
                financialActivities()
              ],
            ),
          ))),
    );
  }

  investingActivities() {
    return Container(
      padding: EdgeInsets.all(20),
      width: 350,
      height: 680,
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  'INVESTING ACTIVITIES',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child: Text(
              'Cash receipt from:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(9)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Sale of Property &          \nequipment',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: salePropertyAndEquipment,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Collection of principal    \n on loans',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: collectionOfPrincipalOnLoans,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Sales of Investment        \n securities',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: saleOfInvestmentSecurities,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 100),
            child: Text(
              'Cash paid for',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(9)),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Purchase of Property       \n & Equipment',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: purchaseOfPropertyandEquipment,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Making loans to                  \n other entities',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: makingLoanstoOtherEntities,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Purchase of Investment   \n securities',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: purchaseOfInvestmentSecurities,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Net Cash from                 \n Investment',
                style: TextStyle(fontSize: 17, color: Colors.green),
                textAlign: TextAlign.left,
              ),
              Container(
                width: 100,
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'N ' + netCashInvestment.toString()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  financialActivities() {
    return Container(
      padding: EdgeInsets.all(20),
      width: 360,
      height: 980,
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 100),
            child: Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  'FINANCING ACTIVITIES',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 170),
            child: Text(
              'Cash Receipt from:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            width: 350,
            height: 120,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(9)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Issuance of Stock        ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: insuranceSupplies,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Borrowing                         ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: borrowing,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 130),
            child: Text(
              'Cash Paid for:                   ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(9)),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Repurchase of Stock          \n (treasure stock)',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: repurchaseOfStock,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Dividends               ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(width: 23),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: dividends,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Repayment of loans          ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: repaymentOfLoans,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Net Cash Flow from \nFinancing',
                style: TextStyle(fontSize: 17, color: Colors.green),
                textAlign: TextAlign.left,
              ),
              Container(
                width: 100,
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'N ' + netCashFlowFinancing.toString()),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Cash at the end of year',
                style: TextStyle(fontSize: 17, color: Colors.green),
                textAlign: TextAlign.left,
              ),
              Container(
                width: 100,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'N ' + cashAtEndOfYear.toString()),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          preview
              ? InkWell(
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[600]),
                    child: Center(
                        child: Text('Preview',
                            style:
                                TextStyle(fontSize: 17, color: Colors.white))),
                  ),
                  onTap: () {
                    setState(() {
                      preview = false;
                    });
                    _calculation();
                  })
              : InkWell(
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[600]),
                    child: Center(
                        child: Text('Generate',
                            style:
                                TextStyle(fontSize: 17, color: Colors.white))),
                  ),
                  onTap: () async {
                    _activitiesServices.checkForInternet().then((value) async {
                      if (value == true) {
                        DialogBoxes().loading(context);
                        dynamic result = await _accountingServices.cashFlow(
                            year,
                            cashAtBeginingOfYear.numberValue.toStringAsFixed(2),
                            otherOperationReceipt.numberValue
                                .toStringAsFixed(2),
                            customer.numberValue.toStringAsFixed(2),
                            inventory.numberValue.toStringAsFixed(2),
                            administrativeExpenses.numberValue
                                .toStringAsFixed(2),
                            wagesSalaryExpenses.numberValue.toStringAsFixed(2),
                            interest.numberValue.toStringAsFixed(2),
                            incomeTaxes.numberValue.toStringAsFixed(2),
                            otherOperations.numberValue.toStringAsFixed(2),
                            netCashFlowOperations.toStringAsFixed(2),
                            salePropertyAndEquipment.numberValue
                                .toStringAsFixed(2),
                            collectionOfPrincipalOnLoans.numberValue
                                .toStringAsFixed(2),
                            saleOfInvestmentSecurities.numberValue
                                .toStringAsFixed(2),
                            otherReturns.numberValue.toStringAsFixed(2),
                            purchaseOfPropertyandEquipment.numberValue
                                .toStringAsFixed(2),
                            makingLoanstoOtherEntities.numberValue
                                .toStringAsFixed(2),
                            purchaseOfInvestmentSecurities.numberValue
                                .toStringAsFixed(2),
                            otherInvestments.numberValue.toStringAsFixed(2),
                            netCashInvestment.toStringAsFixed(2),
                            insuranceSupplies.numberValue.toStringAsFixed(2),
                            borrowing.numberValue.toStringAsFixed(2),
                            otherFinancialIncomeCash.numberValue
                                .toStringAsFixed(2),
                            repurchaseOfStock.numberValue.toStringAsFixed(2),
                            dividends.numberValue.toStringAsFixed(2),
                            repaymentOfLoans.numberValue.toStringAsFixed(2),
                            otherFinancialOutgoingCash.numberValue
                                .toStringAsFixed(2),
                            netCashFlowFinancing.toStringAsFixed(2),
                            cashAtEndOfYear.toStringAsFixed(2));
                        if (result == 201) {
                          Navigator.pop(context);
                          setState(() {
                            _error =
                                'Your Cash Flow has been sent to your email';
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
                    });
                  },
                ),
          SizedBox(height: 20)
        ],
      ),
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

  _calculation() {
    netCashFlowOperations =
        ((customer.numberValue + otherOperationReceipt.numberValue) -
            (inventory.numberValue +
                administrativeExpenses.numberValue +
                wagesSalaryExpenses.numberValue +
                interest.numberValue +
                incomeTaxes.numberValue +
                otherOperations.numberValue));
    netCashInvestment = ((salePropertyAndEquipment.numberValue +
            collectionOfPrincipalOnLoans.numberValue +
            saleOfInvestmentSecurities.numberValue +
            otherReturns.numberValue) -
        (purchaseOfPropertyandEquipment.numberValue +
            makingLoanstoOtherEntities.numberValue +
            purchaseOfInvestmentSecurities.numberValue +
            otherInvestments.numberValue));
    netCashFlowFinancing = ((insuranceSupplies.numberValue +
            borrowing.numberValue +
            otherFinancialIncomeCash.numberValue) -
        (repurchaseOfStock.numberValue +
            dividends.numberValue +
            repaymentOfLoans.numberValue +
            otherFinancialOutgoingCash.numberValue));
    cashAtEndOfYear =
        (netCashFlowOperations + netCashInvestment + netCashFlowFinancing);
  }
}
