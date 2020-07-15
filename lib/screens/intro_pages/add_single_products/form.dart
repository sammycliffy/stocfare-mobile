import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/intro_pages/add_single_products/quantity.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  String _productCategory;
  String _unitProductName;
  int _unitProductPrice;
  int _unitQuantity = 0;
  double _unitLimit = 0;

  String _packProductName;
  int _packProductPrice;
  int _packQuantity = 0;
  double _packLimit = 0;
  String _productDescription;
  String _barCode;
  String _scanBarcode = 'Unknown';
  File _image;

  bool loading = false;
  ProductServices _productServices = ProductServices();
  final picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProduct = Provider.of<AddProductNotifier>(context);
    return Scaffold(
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
                    SizedBox(height: 15),
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
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 160,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
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
                        SizedBox(width: 15),
                        SizedBox(
                          width: 160,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
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
                            (_unitLimit * 100).round().toString(),
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
                    SizedBox(
                      height: 20,
                    ),
                    pack(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 170),
                      child: Text(
                        "Add Image & Barcode",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    barcodeImage(),
                    SizedBox(
                      height: 30,
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
                            _addProduct.setFirstProduct(
                                _productCategory,
                                _unitProductName,
                                _unitProductPrice,
                                _productDescription);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuantityPage()));
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

  pack() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: ExpansionTile(
        title: Text(
          "Upload pack products",
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        children: <Widget>[
          Form(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (input) =>
                      input.isEmpty ? "Enter Product Name " : null,
                  onChanged: (val) => setState(() {
                    _packProductName = val;
                  }),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                    hintStyle: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.7)),
                    hintText: 'Enter Product Name E.g. Cocacola',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.5))),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 160,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (input) =>
                          input.isEmpty ? "Enter Product Price" : null,
                      onChanged: (val) => setState(() {
                        _packProductPrice = int.parse(val);
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
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
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
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
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
                      (_packLimit * 100).round().toString(),
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
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayColor: Colors.red,
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  ),
                  child: Slider(
                    value: _packLimit,
                    onChanged: (value) {
                      setState(() {
                        _packLimit = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  barcodeImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            InkWell(
              child: Container(
                  width: 100,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Icon(
                    Icons.assessment,
                    color: Colors.red,
                    size: 70,
                  )),
              onTap: () {
                scanBarcodeNormal();
              },
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              width: 150,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey)),
              child: Center(
                  child: _scanBarcode == null
                      ? Text('Barcode will show here',
                          style: TextStyle(color: Colors.grey))
                      : Text(
                          _scanBarcode,
                          style: TextStyle(color: Colors.black),
                        )),
            ),
            SizedBox(
              height: 9,
            ),
            Text(
              'Add Barcode',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          width: 60,
        ),
        Column(children: [
          InkWell(
            child: _image == null
                ? Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Icon(Icons.add_a_photo, size: 50, color: Colors.red))
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
            onTap: () {
              getImage();
            },
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            'Add Image',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ])
      ],
    );
  }
}
