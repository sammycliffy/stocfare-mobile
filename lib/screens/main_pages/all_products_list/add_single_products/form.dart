import 'package:currency_pickers/country.dart';
import 'package:currency_pickers/currency_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/color_models.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_single_products/packproduct_form.dart';

import 'barcode_image.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _secondKey = GlobalKey<FormState>();
  final List<String> color = <String>[];
  final List<ColorDataModel> _data = [];

  String _productCategory;
  String _unitProductName;
  String _productDescription;
  int _unitProductSellingPrice = 0;
  int _unitQuantity = 0;
  int _unitLimit = 0;
  int _productDiscount = 0;
  int _productWeight = 0;
  String _colorName;
  int _colorQuantity;
  int _colorLimit;
  int _unitProductCostPrice = 0;
  Country _selectedDialogCountry;
  bool loading = false;
  String _error;
  bool addExtraDetails = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var secondController = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');
  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProduct = Provider.of<AddProductNotifier>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Add Products')),
        key: _scaffoldKey,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (input) =>
                            input.isEmpty ? "Enter product Category" : null,
                        onChanged: (val) => setState(() {
                          _productCategory = val;
                        }),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          labelText: 'Enter product Category',
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
                          hintText: 'Enter Product Category E.g. Soft Drinks',
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
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Tooltip(
                        message: 'James',
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (input) {
                            if (input.isEmpty) {
                              return "Enter Product Name ";
                            } else if (input.length > 23) {
                              return 'Product Name Too Long';
                            }
                            return null;
                          },
                          onChanged: (val) => setState(() {
                            _unitProductName = val;
                          }),
                          decoration: InputDecoration(
                            labelText: 'Enter product Name',
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
                            hintText: 'Enter Product Name E.g. Cocacola',
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
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 150,
                          child: Tooltip(
                            message: 'You must know what you are doing',
                            child: TextFormField(
                              controller: secondController,
                              keyboardType: TextInputType.number,
                              validator: (input) =>
                                  input.isEmpty ? "Enter Product Price" : null,
                              onChanged: (val) => setState(() {
                                _unitProductCostPrice = int.parse(val);
                              }),
                              decoration: InputDecoration(
                                labelText: 'Cost price',
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
                                hintText: 'Unit price',
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
                        ),
                        SizedBox(width: 5),
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            validator: (input) =>
                                input.isEmpty ? "Enter Selling Price" : null,
                            onChanged: (val) => setState(() {
                              _unitProductSellingPrice = int.parse(val);
                            }),
                            decoration: InputDecoration(
                              labelText: 'Selling price',
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
                              hintText: 'Unit price',
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
                          _unitQuantity = int.parse(val);
                        }),
                        decoration: InputDecoration(
                          labelText: 'Quantity',
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
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Limit cannot be empty';
                          } else if (int.parse(val) > _unitQuantity) {
                            return 'Limit cannot be greater than quantity';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onChanged: (val) => setState(() {
                          _unitLimit = int.parse(val);
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
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: Text('What is this?', style: TextStyle()),
                      ),
                      onTap: () {
                        _productLimit(context);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (val) => setState(() {
                          _productDescription = val;
                        }),
                        decoration: InputDecoration(
                          labelText: 'Description',
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
                          hintText: 'Give a brief description of your product',
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
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.green[700]),
                              child: Center(
                                child: Text('Add pack products',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _addProduct.setFirstProduct(
                                    _productCategory,
                                    _unitProductName,
                                    _unitLimit,
                                    _unitQuantity,
                                    controller.numberValue.round(),
                                    _productDescription,
                                    _productDiscount,
                                    _productWeight,
                                    secondController.numberValue.round(),
                                    _data);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPackPage()));
                              }
                            }),
                        SizedBox(width: 20),
                        //check if the extra details button is clicked
                        addExtraDetails
                            ? GestureDetector(
                                child: Text(
                                  'Add Extra Detals',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                onTap: () {
                                  setState(() {
                                    addExtraDetails = false;
                                  });
                                },
                              )
                            : GestureDetector(
                                child: Text(
                                  'Add Extra Detals',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  setState(() {
                                    addExtraDetails = true;
                                  });
                                },
                              )
                      ],
                    ),
                    SizedBox(height: 20),
                    addExtraDetails
                        ? Column(
                            children: <Widget>[
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  // inputFormatters: [controller],
                                  // controller: textEditingController,
                                  keyboardType: TextInputType.number,

                                  onChanged: (val) => setState(() {
                                    _productDiscount = int.parse(val);
                                  }),
                                  decoration: InputDecoration(
                                    labelText: 'Product Discount',
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
                                    hintText: 'Product Discounts (%)',
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
                              SizedBox(height: 20),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  // inputFormatters: [controller],
                                  // controller: textEditingController,
                                  keyboardType: TextInputType.number,

                                  onChanged: (val) => setState(() {
                                    _productWeight = int.parse(val);
                                  }),
                                  decoration: InputDecoration(
                                    labelText: 'Product Weight',
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
                                    hintText: 'Product Weight in (Kg)',
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
                                height: 10,
                              ),
                              color.length == 0
                                  ? SizedBox()
                                  : Container(
                                      height: 150,
                                      width: 320,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(8),
                                          itemCount: color.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Container(
                                                width: 320,
                                                height: 50,
                                                color: Colors.grey[200],
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Text(color[index]),
                                                      IconButton(
                                                          icon: Icon(
                                                              Icons.cancel),
                                                          onPressed: () {
                                                            setState(() {
                                                              color.remove(
                                                                  color[index]);
                                                            });
                                                          })
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                              //Add color form
                              Padding(
                                padding: const EdgeInsets.only(right: 150.0),
                                child: Text('Add Colors',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).primaryColor)),
                              ),
                              Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 3,
                                            color: Colors.grey[200]))),
                              ),
                              SizedBox(height: 20),
                              Form(
                                key: _secondKey,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        validator: (val) => val.isEmpty
                                            ? 'Cannot be empty'
                                            : null,
                                        onChanged: (val) => setState(() {
                                          _colorName = val;
                                        }),
                                        decoration: InputDecoration(
                                          labelText: 'Color Name',
                                          contentPadding: EdgeInsets.all(12),
                                          labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .focusColor
                                                      .withOpacity(0.2))),
                                          hintStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.7)),
                                          hintText: 'Color Name',
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
                                    SizedBox(height: 20),
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) => setState(() {
                                          _colorQuantity = int.parse(val);
                                        }),
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return 'Cannot be empty';
                                          } else if (int.parse(val) <
                                              _colorLimit) {
                                            return 'Quantity cannot be < limit';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Color Quantity',
                                          contentPadding: EdgeInsets.all(12),
                                          labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .focusColor
                                                      .withOpacity(0.2))),
                                          hintStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.7)),
                                          hintText: 'Color Quantity',
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
                                    SizedBox(height: 20),
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        // inputFormatters: [controller],
                                        // controller: textEditingController,
                                        keyboardType: TextInputType.number,
                                        validator: (val) => val.isEmpty
                                            ? 'Cannot be empty'
                                            : null,
                                        onChanged: (val) => setState(() {
                                          _colorLimit = int.parse(val);
                                        }),
                                        decoration: InputDecoration(
                                          labelText: 'Color limit',
                                          contentPadding: EdgeInsets.all(12),
                                          labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .focusColor
                                                      .withOpacity(0.2))),
                                          hintStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.7)),
                                          hintText: 'Color Limit',
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
                              ),
                              RaisedButton(
                                onPressed: () {
                                  if (_secondKey.currentState.validate()) {
                                    setState(() {
                                      color.add(
                                          '$_colorName (Quantity: $_colorQuantity pcs)  (Limit: $_colorLimit pcs)');
                                    });
                                    ColorDataModel _colorData = ColorDataModel(
                                        colorName: _colorName,
                                        colorQuantity: _colorQuantity,
                                        colorLimit: _colorLimit);
                                    _data.add(_colorData);
                                    print(_data);
                                  }
                                },
                                child: const Text('Add Color',
                                    style: TextStyle(fontSize: 20)),
                              )
                            ],
                          )
                        : SizedBox(),
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
                          print(_data);
                          if (_formKey.currentState.validate()) {
                            _addProduct.setFirstProduct(
                              _productCategory,
                              _unitProductName,
                              _unitLimit,
                              _unitQuantity,
                              controller.numberValue.round(),
                              _productDescription,
                              _productDiscount,
                              _productWeight,
                              secondController.numberValue.round(),
                              _data,
                            );

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

  Future<void> _productLimit(context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Product Limit',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'This is the lowest you will want this goods to be before we alert you of a low stock.',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          )),
          actions: <Widget>[],
        );
      },
    );
  }

  void _openCurrencyPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CurrencyPickerDialog(
              titlePadding: EdgeInsets.all(8.0),
              searchCursorColor: Colors.pinkAccent,
              searchInputDecoration: InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: Text('Select your Country code'),
              onValuePicked: (Country country) =>
                  setState(() => _selectedDialogCountry = country),
            )),
      );
}
