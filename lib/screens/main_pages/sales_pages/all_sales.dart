import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/main_app_bar.dart';

class AllSalesList extends StatefulWidget {
  @override
  _AllSalesListState createState() => _AllSalesListState();
}

class _AllSalesListState extends State<AllSalesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerPage(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: MainAppBar.salesListAppBar(context)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100,
              height: 40,
              color: Theme.of(context).hintColor,
              child: Center(
                child: Text('Today',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _today(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              height: 40,
              color: Theme.of(context).hintColor,
              child: Center(
                child: Center(
                  child: Text('This week',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _today(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              height: 40,
              color: Theme.of(context).hintColor,
              child: Center(
                child: Text('This month',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            _today(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              height: 40,
              color: Theme.of(context).hintColor,
              child: Center(
                child: Text('Quarterly',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            _today(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              height: 40,
              color: Theme.of(context).hintColor,
              child: Center(
                child: Text('This year',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_today() {
  return Container(
    height: 200,
    child: ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,

      children: <Widget>[
        GestureDetector(
          child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/laptop.png',
                  width: 150,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Shoes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                    width: 80,
                    decoration: BoxDecoration(color: Colors.green),
                    child: Center(
                        child: Text(
                      '1900',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ))),
                Container(
                    child: Text(
                  'Sold 12',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ))
              ],
            ),
          ),
          onTap: () {
            //if the product number is greater than 3 display the show dialog box
          },
        ),
      ],
    ),
  );
}
