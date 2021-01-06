import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_products_category/barcode_image_to_category.dart';

import 'package:stockfare_mobile/services/product_services.dart';

class AddPackPageCategory extends StatefulWidget {
  @override
  _AddPackPageCategoryState createState() => _AddPackPageCategoryState();
}

class _AddPackPageCategoryState extends State<AddPackPageCategory> {
  final _formKey = GlobalKey<FormState>();
  String _packProductName;
  int _packProductPrice = 0;
  int _packProductCostPrice = 0;
  int _packQuantity = 0;
  int _packLimit = 0;
  bool loading = false;
  var controller = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', leftSymbol: ' NGN ');
  var controller1 = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', leftSymbol: ' NGN ');

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;
  ProductServices _productServices = ProductServices();
  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProduct = Provider.of<AddProductNotifier>(context);
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
            Colors.red[200],
            Colors.white,
          ],
              stops: [
            0.0,
            1.0
          ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.repeated)),
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Add Pack Product'),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 160,
                            child: TextFormField(
                              controller: controller1,
                              keyboardType: TextInputType.number,
                              validator: (input) =>
                                  input.isEmpty ? "Enter Cost Price" : null,
                              onChanged: (val) => setState(() {
                                _packProductCostPrice = int.parse(val);
                              }),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Cost Price',
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
                              controller: controller,
                              keyboardType: TextInputType.number,
                              validator: (input) =>
                                  input.isEmpty ? "Enter Selling Price" : null,
                              onChanged: (val) => setState(() {
                                _packProductPrice = int.parse(val);
                              }),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Selling Price',
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
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (input) =>
                              input.isEmpty ? "Enter Quantity " : null,
                          onChanged: (val) => setState(() {
                            _packQuantity = int.parse(val);
                          }),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Enter Quantity',
                            contentPadding: EdgeInsets.all(12),
                            labelStyle: TextStyle(color: Colors.black),
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
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Unit Limit',
                            contentPadding: EdgeInsets.all(12),
                            labelStyle: TextStyle(color: Colors.black),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                            ),
                          ),
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _addProduct.setPackProductsToCategory(
                                controller.numberValue.round(),
                                _packLimit,
                                _packQuantity ?? 0,
                                controller1.numberValue.round(),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BarcodePageProduct()));
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
          )),
    );
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
