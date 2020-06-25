import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> _currentView = [
    _sales(),
    _product(),
    _lowStock(),
    _mostSold(),
    _orderHistory(),
    _addSales()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _currentView[_currentIndex],
            _homeMenu(),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }

//This is the home Menu tabs which controls the sales and lowstock and others
  Widget _homeMenu() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              InkWell(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Hexcolor("#FF5E69"),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Icon(Icons.card_giftcard,
                        size: 40, color: Colors.white),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                'Sales History',
                style: TextStyle(
                  fontSize: 14,
                ),
              ))
            ],
          ),
          Column(
            children: [
              InkWell(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Hexcolor("#FF5E69"),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Icon(Icons.monetization_on,
                        size: 40, color: Colors.white),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                'Product History',
                style: TextStyle(
                  fontSize: 14,
                ),
              ))
            ],
          ),
          Column(
            children: [
              InkWell(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Hexcolor("#FF5E69"),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Icon(Icons.monetization_on,
                        size: 40, color: Colors.white),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                'Low Stock',
                style: TextStyle(
                  fontSize: 14,
                ),
              ))
            ],
          )
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              InkWell(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Hexcolor("#FF5E69"),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Icon(Icons.card_giftcard,
                        size: 40, color: Colors.white),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                'Most Sold',
                style: TextStyle(
                  fontSize: 14,
                ),
              ))
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: InkWell(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Hexcolor("#FF5E69"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Icon(Icons.shopping_cart,
                          size: 40, color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _currentIndex = 4;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                '    Order History',
                style: TextStyle(
                  fontSize: 14,
                ),
              ))
            ],
          ),
          Column(
            children: [
              InkWell(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Hexcolor("#FF5E69"),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Icon(Icons.add, size: 40, color: Colors.white),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 5;
                  });
                },
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                'Add Sales',
                style: TextStyle(
                  fontSize: 14,
                ),
              ))
            ],
          )
        ],
      )
    ]);
  }
}

//This is the sales view
Widget _sales() {
  return Flexible(
    child: Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Align(
          child: Text('Dashboard',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              )),
        ),
        SizedBox(height: 10),
        Container(
          height: 25,
          color: Colors.black,
          child: Center(
            child: Text(
              'Sales',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
            height: 100,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.black))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/laptop.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      'LAPTOP',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'N10000',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Electricity',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Category'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Sold'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '850',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Discount'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Available'))
                      ],
                    ),
                  ],
                )
              ],
            )),
      ]),
    ),
  );
}

//This is the product view
Widget _product() {
  return Expanded(
    child: Container(
      width: 350,
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Dashboard',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 25,
          color: Colors.black,
          child: Center(
            child: Text(
              'Products',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.black))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/laptop.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      'LAPTOP',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'N10000',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Electricity',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Category'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Sold'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '850',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Discount'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Available'))
                      ],
                    ),
                  ],
                )
              ],
            )),
      ]),
    ),
  );
}

Widget _lowStock() {
  return Expanded(
    child: Container(
      width: 350,
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Dashboard',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 25,
          color: Colors.black,
          child: Center(
            child: Text(
              'Low Stock',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.black))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/laptop.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      'LAPTOP',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'N10000',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Electricity',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Category'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Sold'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '850',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Discount'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Available'))
                      ],
                    ),
                  ],
                )
              ],
            )),
      ]),
    ),
  );
}

Widget _mostSold() {
  return Expanded(
    child: Container(
      width: 350,
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Dashboard',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 25,
          color: Colors.black,
          child: Center(
            child: Text(
              'Most Sold',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.black))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/laptop.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      'LAPTOP',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'N10000',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Electricity',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Category'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Sold'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '850',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Discount'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Available'))
                      ],
                    ),
                  ],
                )
              ],
            )),
      ]),
    ),
  );
}

Widget _orderHistory() {
  return Expanded(
    child: Container(
      width: 350,
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Dashboard',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 25,
          color: Colors.black,
          child: Center(
            child: Text(
              'Order History',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.black))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/laptop.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      'LAPTOP',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'N10000',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Electricity',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Category'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Sold'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '850',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Discount'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Available'))
                      ],
                    ),
                  ],
                )
              ],
            )),
      ]),
    ),
  );
}

Widget _addSales() {
  return Expanded(
    child: Container(
      width: 350,
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Dashboard',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 25,
          color: Colors.black,
          child: Center(
            child: Text(
              'Add Sales',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.black))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/laptop.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      'LAPTOP',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'N10000',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Electricity',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Category'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Sold'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '850',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Discount'))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Center(child: Text('Available'))
                      ],
                    ),
                  ],
                )
              ],
            )),
      ]),
    ),
  );
}
