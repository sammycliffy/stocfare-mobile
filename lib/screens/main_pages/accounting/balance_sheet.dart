import 'package:flutter/material.dart';

class BalanceSheet extends StatefulWidget {
  @override
  _BalanceSheetState createState() => _BalanceSheetState();
}

class _BalanceSheetState extends State<BalanceSheet> {
  int cash = 0;
  int inventory = 0;
  int accountReceivable = 0;
  int prepaidExpenses = 0;
  int shortTermInvestments = 0;
  int totalCurrentAssets = 0;

  int longTermInvestments = 0;
  int propertyPlantAndEquipments = 0;
  int intangibleAssets = 0;
  int totalFixedAssets = 0;
  int totalAssets = 0;

  int accountPayable = 0;
  int shortTermLoans = 0;
  int incomeTaxesPayable = 0;
  int accruedSalariesAndWages = 0;
  int unearnedRevenue = 0;
  int totalCurrentLiabilities = 0;

  int longTermDebt = 0;
  int deferredIncomeTax = 0;
  int longTermOthers = 0;
  int totalLongTermLiabilities = 0;

  int ownersInvestment = 0;
  int retainedEarnings = 0;
  int ownersOthers = 0;
  int totalOwnersEquity = 0;
  int totalLiabilitiesAndOwnersEquity = 0;

  double debtRatio = 0;
  double currentRatio = 0;
  int workingCapital = 0;
  double assetToEquityRatio = 0;
  int debtToEquityRatio = 0;

  @override
  Widget build(BuildContext context) {
    totalCurrentAssets = (cash +
        inventory +
        accountReceivable +
        prepaidExpenses +
        shortTermInvestments);
    totalFixedAssets =
        (longTermInvestments + propertyPlantAndEquipments + intangibleAssets);
    totalAssets = totalCurrentAssets + totalFixedAssets;
    totalCurrentLiabilities = (accountPayable +
        shortTermLoans +
        incomeTaxesPayable +
        accruedSalariesAndWages +
        unearnedRevenue);

    totalLongTermLiabilities =
        (longTermDebt + deferredIncomeTax + longTermOthers);

    totalOwnersEquity = (ownersInvestment + retainedEarnings + ownersOthers);
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
    debtToEquityRatio = ((totalCurrentLiabilities + totalLongTermLiabilities) -
        totalOwnersEquity);
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
                  '[Alibaba Group]',
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
                Text(
                  'For the Year',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Container(
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(),
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
                                    onChanged: (val) {
                                      setState(() {
                                        cash = int.parse(val);
                                      });
                                    },
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
                                    onChanged: (val) => setState(() {
                                      inventory = int.parse(val);
                                    }),
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
                                    onChanged: (val) => setState(() {
                                      accountReceivable = int.parse(val);
                                    }),
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
                                    onChanged: (val) => setState(() {
                                      prepaidExpenses = int.parse(val);
                                    }),
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
                                    onChanged: (val) => setState(() {
                                      shortTermInvestments = int.parse(val);
                                    }),
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
                                  'TOTAL CURRENT ASSETS',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.green),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'N ' +
                                            totalCurrentAssets.toString()),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 120),
                        child: Text(
                          'Fixed (Long Term) Asset',
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
                                    onChanged: (val) => setState(() {
                                      longTermInvestments = int.parse(val);
                                    }),
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
                                    onChanged: (val) => setState(() {
                                      propertyPlantAndEquipments =
                                          int.parse(val);
                                    }),
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
                                    onChanged: (val) => setState(() {
                                      intangibleAssets = int.parse(val);
                                    }),
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
                                  'TOTAL FIXED ASSETS     ',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.green),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText:
                                            'N ' + totalFixedAssets.toString()),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'N ' + totalAssets.toString()),
                            ),
                          ),
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
      height: 1200,
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
                        onChanged: (val) => setState(() {
                          accountPayable = int.parse(val);
                        }),
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
                        onChanged: (val) => setState(() {
                          shortTermLoans = int.parse(val);
                        }),
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Income taxes payable    ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            incomeTaxesPayable = int.parse(val);
                          });
                        },
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
                        onChanged: (val) => setState(() {
                          accruedSalariesAndWages = int.parse(val);
                        }),
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
                        onChanged: (val) => setState(() {
                          unearnedRevenue = int.parse(val);
                        }),
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
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
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText:
                                'N ' + totalCurrentLiabilities.toString()),
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
                        onChanged: (val) => setState(() {
                          longTermDebt = int.parse(val);
                        }),
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Deferred Income Tax',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        onChanged: (val) => setState(() {
                          deferredIncomeTax = int.parse(val);
                        }),
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
                        onChanged: (val) => setState(() {
                          longTermOthers = int.parse(val);
                        }),
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
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
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText:
                                'N ' + totalLongTermLiabilities.toString()),
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
              'Owner\'s Equity',
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
                      'Owner\'s Investment    ',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        onChanged: (val) => setState(() {
                          ownersInvestment = int.parse(val);
                        }),
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
                        onChanged: (val) => setState(() {
                          retainedEarnings = int.parse(val);
                        }),
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
                        onChanged: (val) => setState(() {
                          ownersOthers = int.parse(val);
                        }),
                        decoration: InputDecoration(hintText: 'N0.00'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'TOTAL OWNER\'S      \n EQUITY        ',
                      style: TextStyle(fontSize: 17, color: Colors.green),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        onChanged: (val) => setState(() {
                          totalOwnersEquity = int.parse(val);
                        }),
                        decoration: InputDecoration(
                            hintText: 'N ' + totalOwnersEquity.toString()),
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
                'TOTAL LIABILITIES AND    \n OWNER\'S EQUITY',
                style: TextStyle(fontSize: 20, color: Colors.green),
                textAlign: TextAlign.left,
              ),
              Container(
                width: 100,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText:
                          'N ' + totalLiabilitiesAndOwnersEquity.toString()),
                ),
              ),
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
        height: 650,
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
          SizedBox(height: 10),
          Container(
              width: 350,
              height: 500,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.circular(9)),
              child: Column(children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Debt Ratio \n(Total Liabilities /                \nTotal Assets )            ',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        onChanged: (val) => setState(() {
                          debtRatio = double.parse(val);
                        }),
                        decoration: InputDecoration(
                            hintText: 'N ' + debtRatio.toString()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Current Ratio \n(Current Assets /\nCurrent Liabilities )            ',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        onChanged: (val) => setState(() {
                          currentRatio = double.parse(val);
                        }),
                        decoration: InputDecoration(
                            hintText: 'N ' + currentRatio.toString()),
                      ),
                    ),
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
                      child: TextFormField(
                        onChanged: (val) => setState(() {
                          workingCapital = int.parse(val);
                        }),
                        decoration: InputDecoration(
                            hintText: 'N ' + workingCapital.toString()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Asset-to-Equity Ratio     \n(Total Assets /\nOwner\'s Equity )            ',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        onChanged: (val) => setState(() {
                          assetToEquityRatio = double.parse(val);
                        }),
                        decoration: InputDecoration(
                            hintText: 'N ' + assetToEquityRatio.toString()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Debt-to-Equity Ratio   \n(Total Liabilities -\nOwner\'s Equity )            ',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        onChanged: (val) => setState(() {
                          debtToEquityRatio = int.parse(val);
                        }),
                        decoration: InputDecoration(
                            hintText: 'N ' + debtToEquityRatio.toString()),
                      ),
                    ),
                  ],
                ),
              ])),
          SizedBox(height: 20),
          InkWell(
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[600]),
              child: Center(
                  child: Text('Generate',
                      style: TextStyle(fontSize: 17, color: Colors.white))),
            ),
          )
        ]));
  }
}
