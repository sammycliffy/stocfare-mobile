import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/color_models.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_products_category/barcode_image_to_category.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_products_category/packproduct_category_form.dart';
import 'package:stockfare_mobile/services/product_services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddFormPage extends StatefulWidget {
  @override
  _AddFormPageState createState() => _AddFormPageState();
}

class _AddFormPageState extends State<AddFormPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> color = <String>[];
  final List<ColorDataModel> _data = [];

  String _productCategory;
  String _unitProductName;
  String _productDescription;
  int _unitProductPrice = 0;
  int _unitQuantity = 0;
  double _unitLimit = 0;
  int _productDiscount = 0;
  int _productWeight = 0;
  String _colorName;
  int _colorQuantity;
  int _colorLimit;
  var controller = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');
  bool loading = false;
  String _error;
  bool addExtraDetails = false;
  ProductServices _productServices = ProductServices();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProduct = Provider.of<AddProductNotifier>(context);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (input) =>
                            input.isEmpty ? "Enter Product Name " : null,
                        onChanged: (val) => setState(() {
                          _unitProductName = val;
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
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            validator: (input) =>
                                input.isEmpty ? "Enter Product Price" : null,
                            onChanged: (val) => setState(() {
                              _unitProductPrice = int.parse(val);
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
                        SizedBox(width: 10),
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (input) =>
                                input.isEmpty ? "Enter Quantity " : null,
                            onChanged: (val) => setState(() {
                              _unitQuantity = int.parse(val);
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
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (input) =>
                            input.isEmpty ? "Enter Product Description" : null,
                        onChanged: (val) => setState(() {
                          _productDescription = val;
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
                    SizedBox(height: 5),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Tell us when to notify you',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                              child: Text(
                            (_unitLimit * 500).round().toString(),
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          )),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.grey[400],
                          inactiveTrackColor: Colors.grey[400],
                          trackShape: RectangularSliderTrackShape(),
                          trackHeight: 4.0,
                          thumbColor: Colors.redAccent,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          overlayColor: Colors.red,
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 28.0),
                        ),
                        child: Slider(
                          value: _unitLimit,
                          onChanged: (value) {
                            setState(() {
                              _unitLimit = value;
                            });
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: Text('What is this?', style: TextStyle()),
                      ),
                      onTap: () {
                        _productLimit(context);
                      },
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
                                  color: Theme.of(context).accentColor),
                              child: Center(
                                child: Text('Add pack products',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                if ((_unitLimit * 100).round() >
                                    _unitQuantity) {
                                  setState(() {
                                    _error =
                                        'Your limit should not be greater than quantity';
                                    _displaySnackBar(context);
                                  });
                                } else {
                                  _addProduct.setFirstProduct(
                                      _productCategory,
                                      _unitProductName,
                                      (_unitLimit * 100).round(),
                                      _unitQuantity,
                                      controller.numberValue,
                                      _productDescription,
                                      _productDiscount,
                                      _productWeight,
                                      _data);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddPackPageCategory()));
                                }
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
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  // inputFormatters: [controller],
                                  // controller: textEditingController,
                                  keyboardType: TextInputType.number,

                                  onChanged: (val) => setState(() {
                                    _colorName = val;
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
                                  // inputFormatters: [controller],
                                  // controller: textEditingController,
                                  keyboardType: TextInputType.number,

                                  onChanged: (val) => setState(() {
                                    _colorQuantity = int.parse(val);
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

                                  onChanged: (val) => setState(() {
                                    _colorLimit = int.parse(val);
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
                              RaisedButton(
                                onPressed: () {
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
                            if ((_unitLimit * 100).round() > _unitQuantity) {
                              setState(() {
                                _error =
                                    'Your limit should not be greater than quantity';
                                _displaySnackBar(context);
                              });
                            } else {
                              _addProduct.setFirstProduct(
                                _productCategory,
                                _unitProductName,
                                (_unitLimit * 100).round(),
                                _unitQuantity,
                                controller.numberValue,
                                _productDescription,
                                _productDiscount,
                                _productWeight,
                                _data, //list of product color, quantity and limit
                              );

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BarcodePageProduct()));
                            }
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

// This will display the details of product limit
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
}
