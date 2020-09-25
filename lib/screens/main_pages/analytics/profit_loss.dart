import 'package:flutter/material.dart';

class ProfitAndLossPage extends StatefulWidget {
  @override
  _ProfitAndLossPageState createState() => _ProfitAndLossPageState();
}

class _ProfitAndLossPageState extends State<ProfitAndLossPage> {
  String paymentMethod = 'Select Expense';
  DateTime selectedDate = DateTime.now();
  bool _isNew = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 10),
      _title('Profit', Colors.black),
      _title('Loss', Colors.black)
    ])));
  }

  _title(title, color) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 30),
            ),
          ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _container('Today'),
                          _container('Week'),
                          _container('Month')
                        ]),
                    Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 10),
                        child: Text(
                          '200,000.00',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ))
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ExpansionTile(
              key: PageStorageKey('myScrollable'),
              title: Text(
                "View All",
                style: TextStyle(fontSize: 18.0, color: Colors.green),
              ),
              children: <Widget>[
                ListTile(
                  title: Text('Sugar',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold)),
                  trailing: Text(
                    'N17,000',
                    style: TextStyle(fontSize: 17, color: Colors.green),
                  ),
                )
              ],
            ),
          ),
        ],
      );

  _container(day) => Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        height: 30,
        width: 80,
        child: Center(
            child: Text(day,
                style: TextStyle(color: Theme.of(context).primaryColor))),
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
