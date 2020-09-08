import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';

import 'package:stockfare_mobile/services/product_services.dart';

import 'barcode_image.dart';

class AddPackPage extends StatefulWidget {
  @override
  _AddPackPageState createState() => _AddPackPageState();
}

class _AddPackPageState extends State<AddPackPage> {
  final _formKey = GlobalKey<FormState>();
  String _packProductName;

  int _packProductPrice = 0;
  int _packQuantity = 0;
  int _packLimit = 0;
  var controller = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');
  bool loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProduct = Provider.of<AddProductNotifier>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Add Pack Product'),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 160,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: controller,
                            validator: (input) =>
                                input.isEmpty ? "Enter Product Price" : null,
                            onChanged: (val) => setState(() {
                              _packProductPrice = int.parse(val);
                            }),
                            decoration: InputDecoration(
                              labelText: 'Enter product price',
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
                              hintText: 'Pack price',
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
                        SizedBox(width: 15),
                        SizedBox(
                          width: 160,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (input) =>
                                input.isEmpty ? "Enter Quantity " : null,
                            onChanged: (val) => setState(() {
                              _packQuantity = int.parse(val);
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
                              hintText: 'Quantity',
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
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Limit cannot be empty';
                          } else if (int.parse(val) > _packQuantity) {
                            return 'Limit cannot be greater than quantity';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onChanged: (val) => setState(() {
                          _packLimit = int.parse(val);
                        }),
                        decoration: InputDecoration(
                          labelText: 'Unit Limit',
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
                          hintText: 'Lowest stock quantity',
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
                    SizedBox(height: 5),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                        child: Center(
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Text(
                              'Add',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                          ),
                        ),
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _addProduct.setPackProducts(controller.numberValue,
                                _packLimit, _packQuantity ?? 0);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BarcodePage()));
                          }
                        }),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          _error,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
