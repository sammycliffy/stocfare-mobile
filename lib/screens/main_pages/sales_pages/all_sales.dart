import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';

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
      appBar: AppBar(
        title: Text('Sales List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100,
              height: 40,
              color: Colors.black,
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
            Padding(
              padding: EdgeInsets.only(left: 280),
              child: Container(
                width: 100,
                height: 30,
                color: Colors.green,
                child: Center(
                  child: Text('Total 12000',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              height: 40,
              color: Colors.black,
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
            Padding(
              padding: EdgeInsets.only(left: 280),
              child: Container(
                width: 100,
                height: 30,
                color: Colors.green,
                child: Center(
                  child: Text('Total 12000',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              height: 40,
              color: Colors.black,
              child: Center(
                child: Text('This month',
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
            Padding(
              padding: EdgeInsets.only(left: 280),
              child: Container(
                width: 100,
                height: 30,
                color: Colors.green,
                child: Center(
                  child: Text('Total 12000',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              height: 40,
              color: Colors.black,
              child: Center(
                child: Text('Quarterly',
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
            Padding(
              padding: EdgeInsets.only(left: 280),
              child: Container(
                width: 100,
                height: 30,
                color: Colors.green,
                child: Center(
                  child: Text('Total 12000',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
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
    height: 160,
    child: ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,

      children: <Widget>[
        GestureDetector(
          child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/laptop.png',
                        width: 80,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      Text('Shoes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Container(
                              color: Colors.red,
                              height: 25,
                              width: 70,
                              child: Center(
                                child: Text(
                                  '150000',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '1900',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'Price',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '14/02/2020',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              'Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '18',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'Quantity',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Sammy Cliffy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              'Sold by',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )),
          onTap: () {
            //if the product number is greater than 3 display the show dialog box
          },
        ),
        GestureDetector(
          child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/laptop.png',
                        width: 80,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      Text('Shoes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Container(
                              color: Colors.red,
                              height: 25,
                              width: 70,
                              child: Center(
                                child: Text(
                                  '150000',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '1900',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'Price',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '14/02/2020',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              'Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '18',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'Quantity',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Sammy Cliffy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              'Sold by',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )),
          onTap: () {
            //if the product number is greater than 3 display the show dialog box
          },
        ),
        GestureDetector(
          child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/laptop.png',
                        width: 80,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      Text('Shoes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Container(
                              color: Colors.red,
                              height: 25,
                              width: 70,
                              child: Center(
                                child: Text(
                                  '150000',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '1900',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'Price',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '14/02/2020',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              'Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '18',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'Quantity',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Sammy Cliffy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              'Sold by',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )),
          onTap: () {
            //if the product number is greater than 3 display the show dialog box
          },
        ),
      ],
    ),
  );
}
