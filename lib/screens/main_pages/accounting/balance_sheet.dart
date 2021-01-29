import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/new_profit.dart';
import 'package:stockfare_mobile/models/sales_analytics_model.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/accounting_services.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/analytics_services.dart';
import 'package:stockfare_mobile/services/profit_loss_services.dart';

class BalanceSheet extends StatefulWidget {
  @override
  _BalanceSheetState createState() => _BalanceSheetState();
}

class _BalanceSheetState extends State<BalanceSheet> {
  AccountingServices _accountingServices = AccountingServices();
  ActivitiesServices _activitiesServices = ActivitiesServices();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error = '';
  int year = 0;
  GrossProfit _profitSummary;
  ProfitAndLoss _profitAndLoss = ProfitAndLoss();
  Analytics _checkSales = Analytics();
  SalesAnalytics _salesAnalytics;
  @override
  void initState() {
    super.initState();
    _profitAndLoss.getAllProfit().then((value) {
      _profitSummary = value;
    });
    _checkSales.getAllAnalytics().then((value) {
      _salesAnalytics = value;
    });
  }

  var cash = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var inventory = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var accountReceivable = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var prepaidExpenses = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var shortTermInvestments = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  bool preview = true;
  double totalCurrentAssets = 0;

  var longTermInvestments = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var propertyPlantAndEquipments = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var varangibleAssets = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var shareHolderInvestment = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  double totalFixedAssets = 0;
  double totalAssets = 0;

  var accountPayable = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var shortTermLoans = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var incomeTaxesPayable = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var accruedSalariesAndWages = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var unearnedRevenue = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  double totalCurrentLiabilities = 0;

  var otherAsset = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  double totalOtherAsset = 0;

  var longTermDebt = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var deferredIncomeTax = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var longTermOthers = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  double totalLongTermLiabilities = 0;

  var ownersInvestment = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  double retainedEarnings = 0;
  var ownersOthers = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  double totalOwnersEquity = 0;
  double totalLiabilitiesAndOwnersEquity = 0;
  double debtRatio = 0;
  double currentRatio = 0;
  double workingCapital = 0;
  double assetToEquityRatio = 0;
  double financialGerring = 0;
  double grossProfitMargin = 0;
  double operatingProfitMargin = 0;
  double returnOnCapitalEmployed = 0;
  double capitalEmployed = 0;
  @override
  Widget build(BuildContext context) {
    AddProductNotifier _productNotifier =
        Provider.of<AddProductNotifier>(context, listen: false);
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
          appBar: AppBar(title: Text('Balance Sheet')),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Balance Sheet for',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '[${_signupNotifier.branchName}]',
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
                Text(
                  'For the Year',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 10),
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
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  width: 360,
                  height: 850,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: Container(
                          width: 110,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              'ASSETS',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: Text(
                          'Current Asset:',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: 350,
                        height: 330,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]),
                            borderRadius: BorderRadius.circular(9)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Cash                                 ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: cash,
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
                                  'Inventory                          ',
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
                                  'Account Receivable        ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: accountReceivable,
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
                                  'Prepaid Expenses              ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: prepaidExpenses,
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
                                  'Short-term Investments',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: shortTermInvestments,
                                    decoration:
                                        InputDecoration(hintText: 'N0.00'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'TOTAL CURRENT ASSETS',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.green),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: Center(
                                      child: Text(
                                    'N ' + totalCurrentAssets.toString(),
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                  )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 120),
                        child: Text(
                          'Non Current Asset',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 250,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]),
                            borderRadius: BorderRadius.circular(9)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Long-term Investments   ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: longTermInvestments,
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
                                  'Property, Plant &\nEquipment             ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(width: 23),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: propertyPlantAndEquipments,
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
                                  'Intangible assets           ',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: varangibleAssets,
                                    decoration:
                                        InputDecoration(hintText: 'N0.00'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'TOTAL NON \nCURRENT ASSETS     ',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.green),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: Center(
                                      child: Text(
                                    'N ' + totalFixedAssets.toString(),
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                  )),
                                )
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
                            'TOTAL ASSETS     ',
                            style: TextStyle(fontSize: 20, color: Colors.green),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            width: 100,
                            child: Center(
                                child: Text(
                              'N ' + totalAssets.toString(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                liabilities(),
                SizedBox(height: 50),
                commonRatios()
              ],
            ),
          ))),
    );
  }

  liabilities() {
    return Container(
      padding: EdgeInsets.all(20),
      width: 350,
      height: 1300,
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
                  color: Colors.red[700],
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  'LIABILITIES & OWNERS EQUITY',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child: Text(
              'Current Liabilities:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(9)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Account Payable             ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: accountPayable,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Short-term loans            ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: shortTermLoans,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Current Tax Payable    ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: incomeTaxesPayable,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Accrued Salaries &        \n wages',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: accruedSalariesAndWages,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Unearned revenue       ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: unearnedRevenue,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'TOTAL CURRENT          \n LIABILITIES',
                      style: TextStyle(fontSize: 17, color: Colors.green),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          child: Text(
                        'N ' + totalCurrentLiabilities.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 100),
            child: Text(
              'Long-Term Liabilities',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 250,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(9)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Long-term debt          ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: longTermDebt,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Deferred Tax              ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: deferredIncomeTax,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Others                        ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: longTermOthers,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'TOTAL LONG-TERM \n LIABILITIES     ',
                      style: TextStyle(fontSize: 17, color: Colors.green),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          child: Text(
                        'N ' + totalLongTermLiabilities.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child: Text(
              'Equity           ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 280,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(9)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Owner\'s Investment    ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: ownersInvestment,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Share Holder\'s              \n Investment',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: shareHolderInvestment,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Retained Earnings     ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: retainedEarnings.toStringAsFixed(2)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Others                        ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: ownersOthers,
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'TOTAL  EQUITY        ',
                      style: TextStyle(fontSize: 17, color: Colors.green),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          child: Text(
                        'N ' + totalOwnersEquity.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                    )
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
                'TOTAL LIABILITIES AND    \n OWNER\'S EQUITY',
                style: TextStyle(fontSize: 20, color: Colors.green),
                textAlign: TextAlign.left,
              ),
              Container(
                width: 100,
                child: Center(
                    child: Text(
                  'N ' + totalLiabilitiesAndOwnersEquity.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                )),
              )
            ],
          ),
        ],
      ),
    );
  }

  commonRatios() {
    return Container(
        padding: EdgeInsets.all(20),
        width: 350,
        height: 830,
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  'COMMON FINANCIAL RATIOS',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
              width: 350,
              height: 630,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.circular(9)),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Gross Profit Margin                \n(Gross Profit / \nSales Revenue )            ',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          child: Text(
                        grossProfitMargin.toStringAsFixed(2) + ' %',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Operating Profit Margin         \n(Pt. before Int. & Tax / \nSales Revenue )            ',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          child: Text(
                        operatingProfitMargin.toStringAsFixed(2) + ' %',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Return on Capital Employed \n(Pt. before Int. & Tax / \nCapital Employed )            ',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          child: Text(
                        returnOnCapitalEmployed.toStringAsFixed(2) + ' %',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Debt Ratio                           \n(Total Liabilities /\nTotal Assets )',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          child: Text(
                        debtRatio.toStringAsFixed(2) + ' %',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Current Ratio      \n(Current Assets /     \nCurrent Liabilities )            ',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          child: Text(
                        currentRatio.toStringAsFixed(2) + ' %',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Working Capital \n(Current Assets -\nCurrent Liabilities )            ',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          child: Text(
                        workingCapital.toStringAsFixed(2) + ' %',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Financial Gerring   \n(Long-term Loan /\nEquity + LT Loan )            ',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          child: Text(
                        financialGerring.toStringAsFixed(2) + ' %',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                    )
                  ],
                ),
              ])),
          SizedBox(height: 20),
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
                        if (debtRatio == (0 / 0)) {
                          print('space cannot be empty');
                        }
                        DialogBoxes().loading(context);
                        dynamic result = await _accountingServices.balanceSheet(
                            cash.numberValue.toStringAsFixed(2),
                            inventory.numberValue.toStringAsFixed(2),
                            accountReceivable.numberValue.toStringAsFixed(2),
                            prepaidExpenses.numberValue.toStringAsFixed(2),
                            shortTermInvestments.numberValue.toStringAsFixed(2),
                            totalCurrentAssets.toStringAsFixed(2),
                            longTermInvestments.numberValue.toStringAsFixed(2),
                            propertyPlantAndEquipments.numberValue
                                .toStringAsFixed(2),
                            varangibleAssets.numberValue.toStringAsFixed(2),
                            totalFixedAssets.toStringAsFixed(2),
                            totalAssets.toStringAsFixed(2),
                            accountPayable.numberValue.toStringAsFixed(2),
                            shortTermLoans.numberValue.toStringAsFixed(2),
                            incomeTaxesPayable.numberValue.toStringAsFixed(2),
                            accruedSalariesAndWages.numberValue
                                .toStringAsFixed(2),
                            unearnedRevenue.numberValue.toStringAsFixed(2),
                            totalCurrentLiabilities.toStringAsFixed(2),
                            longTermDebt.numberValue.toStringAsFixed(2),
                            deferredIncomeTax.numberValue.toStringAsFixed(2),
                            longTermOthers.numberValue.toStringAsFixed(2),
                            totalLongTermLiabilities.toStringAsFixed(2),
                            ownersInvestment.numberValue.toStringAsFixed(2),
                            retainedEarnings.toStringAsFixed(2),
                            ownersOthers.numberValue.round(),
                            totalOwnersEquity.toStringAsFixed(2),
                            totalLiabilitiesAndOwnersEquity.toStringAsFixed(2),
                            grossProfitMargin.toStringAsFixed(2),
                            operatingProfitMargin.toStringAsFixed(2),
                            returnOnCapitalEmployed.toStringAsFixed(2),
                            debtRatio.toStringAsFixed(2),
                            currentRatio.toStringAsFixed(2),
                            workingCapital.toStringAsFixed(2),
                            shareHolderInvestment.numberValue
                                .toStringAsFixed(2),
                            financialGerring.toStringAsFixed(2),
                            year);

                        if (result == 201) {
                          Navigator.pop(context);
                          setState(() {
                            _error =
                                'Your Balance Sheet has been sent to your email';
                            _displaySnackBarSuccess(context);
                          });
                        } else {
                          Navigator.pop(context);
                          setState(() {
                            _error = result.toString();
                            _displaySnackBar(context);
                          });
                        }
                      }
                    });
                  },
                )
        ]));
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
    capitalEmployed = totalOwnersEquity + longTermDebt.numberValue;
    setState(() {
      retainedEarnings = _profitSummary.retainedEarnings.toDouble();
      grossProfitMargin =
          (_profitSummary.grossProfit.year.totalAmount.toDouble() /
                  _salesAnalytics.yearSalesAmount.toDouble()) *
              100 /
              1;
      operatingProfitMargin = (_profitSummary.netProfit.year.toDouble() /
              _salesAnalytics.yearSalesAmount.toDouble()) *
          100 /
          1;

      returnOnCapitalEmployed =
          (_profitSummary.netProfit.year.toDouble() / capitalEmployed) *
              100 /
              1;
      totalCurrentAssets = (cash.numberValue +
          inventory.numberValue +
          accountReceivable.numberValue +
          prepaidExpenses.numberValue +
          shortTermInvestments.numberValue);
      totalFixedAssets = (longTermInvestments.numberValue +
          propertyPlantAndEquipments.numberValue +
          varangibleAssets.numberValue);
      totalAssets = totalCurrentAssets + totalFixedAssets + totalOtherAsset;
      totalCurrentLiabilities = (accountPayable.numberValue +
          shortTermLoans.numberValue +
          incomeTaxesPayable.numberValue +
          accruedSalariesAndWages.numberValue +
          unearnedRevenue.numberValue);

      totalLongTermLiabilities = (longTermDebt.numberValue +
          deferredIncomeTax.numberValue +
          longTermOthers.numberValue);

      totalOwnersEquity = (ownersInvestment.numberValue +
          retainedEarnings +
          shareHolderInvestment.numberValue +
          ownersOthers.numberValue);
      totalLiabilitiesAndOwnersEquity = (totalCurrentLiabilities +
          totalLongTermLiabilities +
          totalOwnersEquity);

      debtRatio =
          ((totalCurrentLiabilities + totalLongTermLiabilities) / totalAssets);
      currentRatio =
          (totalAssets / (totalCurrentLiabilities + totalLongTermLiabilities));

      workingCapital =
          (totalAssets - (totalCurrentLiabilities + totalLongTermLiabilities));

      assetToEquityRatio = (totalAssets / totalOwnersEquity);
      financialGerring = (longTermDebt.numberValue /
              (totalOwnersEquity + longTermDebt.numberValue)) *
          100 /
          1;
    });
  }
}
