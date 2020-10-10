import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/create_sales_model.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/screens/main_pages/sales_pages/sales_receipt.dart';
import 'package:stockfare_mobile/services/sales_services.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  SalesServices _salesServices = SalesServices();

  String paymentMethod = 'CASH';
  int quantity = 0;
  bool newvalue = false;
  DateTime selectedDate = DateTime.now();
  int tax = 0;
  int customerChange = 0;
  String customerName;
  String customerMobile;
  String customerEmail;
  bool soldOnCredit;
  String customerAddress;
  int initialDeposit = 0;
  int editedPrice = 0;
  AddProductToCart _addProduct;
  String _error;
  static List _prices = [];
  static List _names = [];
  static List _quantity = [];
  static List _type = [];
  static List _id = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    _prices.clear();
    _names.clear();
    _type.clear();
    _quantity.clear();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addProduct = Provider.of<AddProductToCart>(context, listen: false);
      print(_addProduct.items.map((value) {
        setState(() {
          _prices.add(value['totalCost']);
          _names.add(value['name']);
          _quantity.add(value['totalQuantity']);
          _type.add(value['type']);
          _id.add(value['id']);
        });
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    AddProductToCart addProduct = Provider.of<AddProductToCart>(context);
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    var controller = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    var controller1 = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    controller1.updateValue(
        _prices.isEmpty ? 0.0 : _prices.reduce((a, b) => a + b).toDouble());
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('CHECKOUT')),
        body: Padding(
          padding: const EdgeInsets.only(left: 40, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('TOTAL PRODUCTS',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(
                      width: 80,
                    ),
                    Text(addProduct.items.length.toString(),
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Text('TOTAL PRICE',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(
                      width: 60,
                    ),
                    Text(controller1.text,
                        style: Theme.of(context).textTheme.headline6)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('PAYMENT METHOD',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(
                      width: 50,
                    ),
                    DropdownButton<String>(
                      value: paymentMethod,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 4,
                        color: Theme.of(context).primaryColor,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          paymentMethod = newValue;
                        });
                      },
                      items: <String>[
                        'CASH',
                        'CARD',
                        'TRANSFER',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) => setState(() {
                            tax = int.parse(val);
                          }),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            hintText: 'Tax',
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
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) => setState(() {
                            customerChange = int.parse(val);
                          }),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            hintText: 'Change',
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
                      ),
                      SizedBox(width: 50),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 40),
                  child: ExpansionTile(
                    key: PageStorageKey('textFormField'),
                    title: Text(
                      "CUSTOMER",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w700),
                    ),
                    children: <Widget>[
                      Form(
                        child: Column(
                          key: PageStorageKey('textFormField'),
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 40),
                              child: TextFormField(
                                onChanged: (val) => setState(() {
                                  customerName = val;
                                }),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.person,
                                      color: Theme.of(context).accentColor),
                                  hintText: 'Customer name',
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 40),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                onChanged: (val) => setState(() {
                                  customerMobile = val;
                                }),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.phone_android,
                                      color: Theme.of(context).accentColor),
                                  hintText: 'Customer phone',
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 40),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                onChanged: (val) => setState(() {
                                  customerAddress = val;
                                }),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.phone_android,
                                      color: Theme.of(context).accentColor),
                                  hintText: 'Customer address',
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 40),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                validator: (input) =>
                                    input.isEmpty ? "Customer email" : null,
                                onChanged: (val) => setState(() {}),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.alternate_email,
                                      color: Theme.of(context).accentColor),
                                  hintText: 'Customer Email',
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 40),
                    child: ExpansionTile(
                      key: PageStorageKey('textFormField'),
                      title: Text(
                        "SOLD ON CREDIT",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                      children: [_soldOnCredit(context)],
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                      width: 300,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2, color: Colors.grey)),
                      child: ListView.builder(
                        itemCount: _names.length,
                        itemBuilder: (context, index) {
                          controller.updateValue(_prices[index].toDouble());
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(_names[index],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700])),
                                  Text(controller.text,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                  InkWell(
                                      child:
                                          Icon(Icons.edit, color: Colors.grey),
                                      onTap: () {
                                        _editPrice(
                                            context,
                                            _prices[index].toString(),
                                            _id[index]);
                                      })
                                ],
                              )
                            ],
                          );
                        },
                      )),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: GestureDetector(
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 190,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 3),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text(
                            'CHECKOUT PRODUCT',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                        ),
                      ),
                      onTap: () {
                        DialogBoxes().loading(context);
                        Future<CreateSalesModel> _createSales = _salesServices
                            .addSales(
                                addProduct.items,
                                customerName,
                                customerAddress,
                                customerMobile,
                                customerEmail,
                                addProduct.prices,
                                customerChange,
                                paymentMethod,
                                newvalue,
                                initialDeposit,
                                tax,
                                selectedDate.toLocal(),
                                _prices.reduce((a, b) => a + b))
                            .catchError((e) {
                          return null;
                        }).timeout(Duration(seconds: 10),
                                onTimeout: () => null);

                        if (_createSales == null) {
                          setState(() {
                            _error = 'Network Error, please try again.';

                            _displaySnackBar(context);
                          });
                        } else {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SalesReceipt(value: _createSales)));
                        }
                      }),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ));
  }

  _soldOnCredit(context) {
    return ListBody(key: PageStorageKey('textFormField'), children: [
      Padding(
        padding: const EdgeInsets.only(left: 5, right: 40),
        child: TextFormField(
          keyboardType: TextInputType.number,
          validator: (input) => input.isEmpty ? "Initial Deposit" : null,
          onChanged: (val) => setState(() {}),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2))),
            hintStyle:
                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
            hintText: 'Initial Deposit',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.5))),
          ),
          style: TextStyle(color: Colors.black),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          "${selectedDate.toLocal()}".split(' ')[0],
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: () => _selectDate(context),
          child: Text(
            'Select Promised date',
            style: TextStyle(color: Colors.white),
          ),
        ),
      )
    ]);
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          _error.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _editPrice(
    context,
    price,
    productId,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        AddProductToCart addProduct = Provider.of<AddProductToCart>(context);
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Edit Price',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  height: 40,
                  width: 200,
                  child: TextField(
                      onChanged: (val) => setState(() {
                            editedPrice = int.parse(val);
                          }),
                      decoration: InputDecoration(
                        labelText: price,
                        hintText: price,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400])),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400])),
                      ))),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: () {
                  sellUnitProduct(productId, price);
                  addProduct.addTotal(editedPrice);
                  Navigator.pop(context);
                  print(addProduct.total);
                },
                child: Text('Save', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
              ),
            ],
          )),
        );
      },
    );
  }

  void sellUnitProduct(_productId, price) {
    bool _itemFound = false;
    int _index;
    for (var i = 0; i < _addProduct.items.length; i++) {
      if (_addProduct.items.length >= 1 &&
          _addProduct.items[i]['id'] == _productId) {
        _itemFound = true;
        _index = i;
        break;
      } else {
        print('Item Not Exists');
      }
    }
    if (_itemFound == true) {
      _addProduct.items[_index]['totalCost'] = editedPrice;
      _addProduct.addItem(_addProduct.items);
      _prices = [];
      _names = [];
      _quantity = [];
      _type = [];
      _id = [];
      print(_addProduct.items.map((value) {
        setState(() {
          _prices.add(value['totalCost']);
          _names.add(value['name']);
          _quantity.add(value['totalQuantity']);
          _type.add(value['type']);
          _id.add(value['id']);
        });
      }));
    }
  }
}
