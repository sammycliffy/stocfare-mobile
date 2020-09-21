import 'package:flutter/material.dart';

class IncomeHomePage extends StatefulWidget {
  @override
  _IncomeHomePageState createState() => _IncomeHomePageState();
}

class _IncomeHomePageState extends State<IncomeHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.black),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Container(
                    height: 120,
                    width: 350,
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
                                fontSize: 40, fontWeight: FontWeight.bold),
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
                    height: 120,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[200]),
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
                padding: const EdgeInsets.only(left: 35.0, top: 10),
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

  _container(day) => Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        height: 30,
        width: 80,
        child: Center(
            child: Text(day,
                style: TextStyle(color: Theme.of(context).primaryColor))),
      );

  _listTile(name, date, amount) => Center(
        child: Container(
          width: 350,
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
}
