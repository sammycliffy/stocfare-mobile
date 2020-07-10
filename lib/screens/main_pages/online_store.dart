import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/main_app_bar.dart';

class OnlineStore extends StatefulWidget {
  @override
  _OnlineStoreState createState() => _OnlineStoreState();
}

class _OnlineStoreState extends State<OnlineStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerPage(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: MainAppBar.appBarFunction(context, 'Online Store')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100,
              height: 40,
              color: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text('Delivered',
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
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text('Pending',
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
