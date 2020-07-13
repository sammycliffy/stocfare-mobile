import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';

class ProductsAvailable extends StatefulWidget {
  @override
  _ProductsAvailableState createState() => _ProductsAvailableState();
}

class _ProductsAvailableState extends State<ProductsAvailable> {
  String dropdownValue = 'Unit';
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    AddProductToCart addProduct = Provider.of<AddProductToCart>(context);
    return GridView.count(
      childAspectRatio: (itemWidth / itemHeight),
      crossAxisCount: 3,
      children: List.generate(100, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    'assets/images/laptop.png',
                    width: 80,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(
                      width: 80,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Center(
                          child: Text(
                        '1900',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))),
                ],
              ),
            ),
            onTap: () {
              //if the product number is greater than 3 display the show dialog box
              addProduct.increment();
              if (addProduct.product > 3) {
                _showMyDialog(context);
              }
            },
          ),
        );
      }),
    );
  }

// Dialog box
  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        AddProductToCart addProduct = Provider.of<AddProductToCart>(context);
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Product Type:',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 40),
                  _dropDown(dropdownValue)
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Quantity',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 50),
                  SizedBox(
                      width: 80,
                      child: TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter quantity' : null,
                        onChanged: (val) => setState(() {
                          quantity = int.parse(val);
                        }),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                        ),
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              )
            ],
          )),
          actions: <Widget>[
            GestureDetector(
                child: Center(
                  child: Container(
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Add Item',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  addProduct.setProductValue(quantity);
                }),
          ],
        );
      },
    );
  }

  //Dropdown list
  Widget _dropDown(String value) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Theme.of(context).primaryColor),
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>[
        'Unit',
        'Pack',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
