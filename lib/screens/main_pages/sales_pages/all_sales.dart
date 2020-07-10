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
        body: Column(
          children: <Widget>[
            Container(
              height: 40,
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 160.0,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text(
                        'Today',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: 160.0,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text('This week',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    width: 160.0,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text('This month',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    width: 160.0,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text('This quarter',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    width: 160.0,
                    color: Theme.of(context).primaryColor,
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
            Expanded(
              child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(100, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      child: Container(
                        width: 50,
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Container(
                                width: 80,
                                decoration: BoxDecoration(color: Colors.green),
                                child: Center(
                                    child: Text(
                                  '1900',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ))),
                            Container(
                                child: Text(
                              'Sold: 12  Left: 9',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  );
                }),
              ),
            )
          ],
        ));
  }
}
