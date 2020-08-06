import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';

enum SingingCharacter { pack, unit }

class DialogBoxes {
  loading(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Just a moment',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              CircularProgressIndicator()
            ],
          )),
        );
      },
    );
  }

  success(context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Updated Successfully',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 60,
                ),
              )
            ],
          )),
        );
      },
    );
  }

  packProduct(context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        AddProductToCart _addProduct = Provider.of<AddProductToCart>(context);
        int _productQuantity = 0;
        List items = _addProduct.items;
        List type = _addProduct.type;
        String _character = 'pack';
        bool _pack = true;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(_addProduct.productName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          _pack
                              ? Text(_addProduct.productPackPrice.toString())
                              : Text(_addProduct.productUnitPrice.toString())
                        ],
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 80),
                          child: Stack(
                            children: [
                              Icon(Icons.shopping_cart,
                                  size: 30, color: Colors.black),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 20),
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.black),
                                  child: Center(
                                    child: Text(
                                      items.length.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          // _addProduct.increment();
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Sell product as',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    child: ListTile(
                      title: const Text('Pack'),
                      leading: Radio(
                        value: 'pack',
                        groupValue: _character,
                        onChanged: (String value) {
                          setState(() {
                            _character = value;
                            _pack = true;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    child: ListTile(
                      title: const Text('Unit'),
                      leading: Radio(
                        value: 'unit',
                        groupValue: _character,
                        onChanged: (String value) {
                          setState(() {
                            _character = value;
                            _pack = false;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (val) => setState(() {
                      _productQuantity = int.parse(val);
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
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
                      hintText: 'Purchase Quantity',
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
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () {
                          for (var i = 0; i < _productQuantity; i++) {
                            setState(() {
                              items.add(_addProduct.productName);
                              if (_character == 'pack') {
                                type.add('pack');
                              } else {
                                type.add('unit');
                              }
                            });
                            _addProduct.addItems(items, type);
                          }
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text('Check out'),
                          ),
                        ),
                        onTap: () {
                          print(items);
                          print(type);
                        },
                      )
                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
