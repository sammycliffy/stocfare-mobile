import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/intro_pages/fourth_intro.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'common_intro_widgets/all_products_appbar.dart';

class AllProductPage extends StatefulWidget {
  @override
  _AllProductPageState createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  int _product;
  int _amount = 10000;

  @override
  Widget build(BuildContext context) {
    AddProductToCart addProduct = Provider.of<AddProductToCart>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBarAllProducts(),
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 25),
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2, color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/laptop.png',
                        width: 70,
                        height: 70,
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        'HP LAPTOP',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Available:',
                          ),
                          SizedBox(width: 20),
                          Text('200     ')
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Quantity:    '),
                          SizedBox(
                            width: 50,
                            height: 30,
                            child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  _product = int.parse(val);
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text('N10000',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      RaisedButton(
                          onPressed: () {
                            addProduct.setProductValue(_product);
                            addProduct.setPrice(_amount);
                          },
                          child: Text('Add Item'))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
