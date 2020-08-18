import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/services/payment_services.dart';

enum SingingCharacter { pack, unit }

class DialogBoxes {
  PaymentServices _paymentServices = PaymentServices();
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

  accountDetails(context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Bank Details',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Account Name',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('Contrail Store',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        'Account Number',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('0565459962',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        'Account Bank',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('GTBank',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        'CONTACT NUMBER',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('09019955835',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ))
            ],
          )),
        );
      },
    );
  }

  promoCode(context) {
    String _promoCode;
    String _result = '';
    bool _error = false;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Text(
                    'APPLY A PROMO CODE',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    _result,
                    style: TextStyle(
                        color: _error ? Colors.red : Colors.green,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onChanged: (val) => setState(() {
                      _promoCode = val;
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
                      hintText: 'Enter Promo code',
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
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                      onPressed: () {
                        _paymentServices.promoCode(_promoCode).then((value) {
                          if (value == true) {
                            setState(() {
                              _result = 'Success!';
                            });
                          } else {
                            setState(() {
                              _error = true;
                              _result = 'Invalid Promo code';
                            });
                          }
                        });
                      },
                      color: Colors.black,
                      child: Text(
                        'Apply Code',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                  Text('Promo code will be applied on next payment')
                ],
              ));
            }));
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
        String _character = 'pack';
        List _quantity = _addProduct.listOfQuantity;
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
                                      (_addProduct.product + _productQuantity)
                                          .toString(),
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
                              if (items.length == 0) {
                                if (_character == 'pack') {
                                  items.add({
                                    '\'totalQuantity\'': _productQuantity,
                                    '\'type\'': '\'pack\'',
                                    '\'id\'': '\'${_addProduct.productId}\'',
                                    '\'price\'': _addProduct.productPackPrice *
                                        _productQuantity,
                                    '\'name\'':
                                        '\'${_addProduct.productName}\'',
                                  });
                                } else {
                                  items.add({
                                    '\'totalQuantity\'': _productQuantity,
                                    '\'type\'': '\'unit\'',
                                    '\'id\'': '\'${_addProduct.productId}\'',
                                    '\'price\'': _addProduct.productUnitPrice *
                                        _productQuantity,
                                    '\'name\'':
                                        '\'${_addProduct.productName}\'',
                                  });
                                }
                              } else {
                                for (var map in items) {
                                  if (map.containsKey('\'id\'')) {
                                    if (map['\'id\''] ==
                                        '\'${_addProduct.productId}\'') {
                                      map['\'totalQuantity\''] =
                                          _productQuantity;
                                      map['\'type\''] = _character;
                                      if (_character == 'pack') {
                                        map['\'price\''] =
                                            _addProduct.productPackPrice *
                                                _productQuantity;
                                      } else {
                                        map['\'price\''] =
                                            _addProduct.productUnitPrice *
                                                _productQuantity;
                                      }
                                    } else {
                                      if (_character == 'pack') {
                                        items.add({
                                          '\'totalQuantity\'': _productQuantity,
                                          '\'type\'': '\'pack\'',
                                          '\'id\'':
                                              '\'${_addProduct.productId}\'',
                                          '\'price\'':
                                              _addProduct.productPackPrice *
                                                  _productQuantity,
                                          '\'name\'':
                                              '\'${_addProduct.productName}\'',
                                        });
                                      } else {
                                        items.add({
                                          '\'totalQuantity\'': _productQuantity,
                                          '\'type\'': '\'unit\'',
                                          '\'id\'':
                                              '\'${_addProduct.productId}\'',
                                          '\'price\'':
                                              _addProduct.productUnitPrice *
                                                  _productQuantity,
                                          '\'name\'':
                                              '\'${_addProduct.productName}\'',
                                        });
                                      }
                                      break;
                                    }
                                  }
                                }
                              }
                            });
                            print(items);
                            _addProduct.addItems(items, _addProduct.countItem);
                            _addProduct.addQuantity(_productQuantity);
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
                          // print(type);
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

  unitProduct(context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        AddProductToCart _addProduct = Provider.of<AddProductToCart>(context);
        int _productQuantity = 0;
        List items = _addProduct.items;
        List _quantity = [];

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
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(_addProduct.productUnitPrice.toString())
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
                                      _productQuantity.toString(),
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
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Product available as unit',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
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
                          _addProduct.addQuantity(_productQuantity);

                          bool itemFound = false;
                          for (var i = 0; i < items.length; i++) {
                            if (items.length >= 1 &&
                                items[i]['\'id\''] ==
                                    '\'${_addProduct.productId}\'') {
                              itemFound = true;
                              _addProduct.setIndex(i);
                              break;
                            } else {
                              print('Item Not Exists');
                            }
                          }
                          if (itemFound == true) {
                            print(itemFound);
                            items[_addProduct.index]['\'totalQuantity\''] =
                                _addProduct.quantity;
                            items[_addProduct.index]['\'price\''] =
                                _addProduct.quantity *
                                    _addProduct.productUnitPrice;
                          } else {
                            items.add({
                              '\'totalQuantity\'': _productQuantity,
                              '\'type\'': '\'unit\'',
                              '\'id\'': '\'${_addProduct.productId}\'',
                              '\'price\'': _addProduct.productUnitPrice *
                                  _productQuantity,
                              '\'name\'': '\'${_addProduct.productName}\'',
                            });
                          }
                          print(items.map((value) {
                            return _quantity.add(value['\'totalQuantity\'']);
                          }));
                          _addProduct.setListOfQuantity(_quantity);
                          print(_addProduct.listOfQuantity);
                          Navigator.pop(context);
                          print(items);
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
                          // print(type);
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
