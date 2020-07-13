import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/main_app_bar.dart';

class AllProductsList extends StatefulWidget {
  @override
  _AllProductsListState createState() => _AllProductsListState();
}

class _AllProductsListState extends State<AllProductsList> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerPage(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Product List'),
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    color: Colors.grey[200],
                    width: 100,
                    height: 40,
                    child: Center(
                        child: Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ))),
                Expanded(
                  child: Container(
                    height: 40,
                    child: ListView(
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 160.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border(
                                  right: BorderSide(
                                      width: 1, color: Colors.white))),
                          child: Center(
                            child: Text(
                              'Electricity',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: 160.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border(
                                  right: BorderSide(
                                      width: 1, color: Colors.white))),
                          child: Center(
                            child: Text('Food Stuffs',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          width: 160.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border(
                                  right: BorderSide(
                                      width: 1, color: Colors.white))),
                          child: Center(
                            child: Text('Home Appliances',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          width: 160.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border(
                                  right: BorderSide(
                                      width: 1, color: Colors.white))),
                          child: Center(
                            child: Text('Cements',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          width: 160.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border(
                                  right: BorderSide(
                                      width: 1, color: Colors.white))),
                          child: Center(
                            child: Text('Fashion',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/laptop.png',
                          width: 80,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Shoes',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        Column(
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
                        Column(
                          children: <Widget>[
                            Text(
                              '15',
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
                        Column(
                          children: <Widget>[
                            Text(
                              '15554447788',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'Barcode',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                        Icon(Icons.delete_forever,
                            color: Theme.of(context).primaryColor)
                      ],
                    ));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ))
          ],
        ));
  }
}
