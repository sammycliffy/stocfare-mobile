import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_single_products/form.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/expenses/home.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: [
            Column(children: [
              IconButton(
                  icon: Icon(Icons.multiline_chart, color: Colors.white),
                  onPressed: null)
            ])
          ],
        ),
        drawer: DrawerPage(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 200),
              child: Text(
                'Welcome Sammy!',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _container('Add Inventory', Hexcolor('#41755C'), 'Make a Sale',
                FormPage()),
            SizedBox(height: 15),
            _container('Checkout', Hexcolor('#E88D49'), 'Add Inventory',
                BottomNavigationPage()),
            SizedBox(height: 15),
            _container('Monthly Expense', Hexcolor('#40A099'), 'Add Inventory',
                ExpensesHome()),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 200),
              child: Text(
                'YOUR BUSINESS REPORT',
                style: TextStyle(fontSize: 18, color: Colors.grey[800]),
              ),
            ),
            Container(
              height: 150,
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Hexcolor('#40A099'),
                          borderRadius: BorderRadius.circular(10)),
                      width: 120.0,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Today',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '55666',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Hexcolor('#40A099'),
                          borderRadius: BorderRadius.circular(10)),
                      width: 120.0,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'This Week',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '55666',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Hexcolor('#40A099'),
                          borderRadius: BorderRadius.circular(10)),
                      width: 120.0,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'This Month',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '55666',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Hexcolor('#40A099'),
                          borderRadius: BorderRadius.circular(10)),
                      width: 120.0,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Quarter',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '55666',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Hexcolor('#40A099'),
                          borderRadius: BorderRadius.circular(10)),
                      width: 120.0,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'This Year',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '55666',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 250),
              child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange[800],
                  ),
                  child: Center(
                      child: Text('View all',
                          style: TextStyle(color: Colors.white)))),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        )));
  }

  _container(name, color, description, route) => GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 5, right: 10),
        width: 350,
        height: 105,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), color: color
                // gradient: LinearGradient(
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                //   stops: [0.1, 0.5, 0.7, 0.9],
                //   colors: [
                //     color[400],
                //     color[600],
                //     color[700],
                //     color[800],
                //   ],
                // ),
                ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(description,
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              Icon(Icons.arrow_forward, size: 30, color: Colors.white),
            ])
          ],
        ),
      ),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => route)));
}
