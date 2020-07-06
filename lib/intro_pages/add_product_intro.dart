import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stockfare_mobile/intro_pages/success_product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'common_intro_widgets/app_bar.dart';

class AddProductIntro extends StatefulWidget {
  @override
  _AddProductIntroState createState() => _AddProductIntroState();
}

class _AddProductIntroState extends State<AddProductIntro> {
  double _value = 0; // value for quantity availabe
  double _quantity = 0; // value for low stock alert
  String _error = ''; // multile image error
  File _image; // Single image file
  String _barcode;
  final picker = ImagePicker();
  final _formkey = GlobalKey<FormState>();
  String _productName;
  String _productCategory;
  String _barCode;
  String _productPrice;
  String _productDescription;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void getBarcode() async {
    var result = await BarcodeScanner.scan();
    setState(() {
      _barcode = result.rawContent;
    });

    //print(result.type); The result type (barcode, cancelled, failed)
    //print(result.rawContent); // The barcode content
    //print(result.format); // The barcode format (as enum)
    //print(result.formatNote); // If a unknown format was scanned this field contains a note
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10.0),
            child: AppBarProducts(),
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  InkWell(
                    child: _image == null
                        ? Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                              child: Icon(Icons.add_a_photo,
                                  size: 50, color: Colors.grey),
                            ))
                        : Image.file(
                            _image,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 80,
                          ),
                    onTap: () {
                      getImage();
                    },
                  ),
                  SizedBox(height: 6),
                  Text('Add Image'),
                ]),
                SizedBox(height: 12),
                Column(children: [
                  InkWell(
                    child: Container(
                        width: 100,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Icon(
                          Icons.assessment,
                          color: Colors.grey,
                          size: 50,
                        )),
                    onTap: () {
                      getBarcode();
                    },
                  ),
                  SizedBox(height: 6),
                  _barcode == null ? Text('Add Barcode') : Text(_barcode),
                ])
              ],
            ),
            SizedBox(height: 30),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      width: 320,
                      child: TextFormField(
                        validator: (val) => val.isEmpty
                            ? 'Enter product Category. E.g. Soft Drinks'
                            : null,
                        onChanged: (val) => setState(() {
                          _productCategory = val;
                        }),
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          hintText: 'Enter product Category. E.g. Soft Drinks',
                          filled: true,
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
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: 320,
                      child: TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter Product Name' : null,
                        onChanged: (val) => setState(() {
                          _productName = val;
                        }),
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          hintText: 'Enter product Name',
                          filled: true,
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
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: 320,
                      child: TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter product price' : null,
                        onChanged: (val) => setState(() {
                          _productPrice = val;
                        }),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          hintText: 'Enter Product (Unit) Price',
                          filled: true,
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
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: 320,
                      child: TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Product Description' : null,
                        onChanged: (val) => setState(() {
                          _productDescription = val;
                        }),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          hintText: 'Product Description',
                          filled: true,
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
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        'Quantity in Stock',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '       Total Products available in Stock',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Text(
                                (_value * 100).round().toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          )
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
                          value: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      _error,
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                )),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: 300,
              child: Text(
                'Low Stock Alert',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(
                '      When to alert on low stock           ',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Flexible(
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text(
                    (_quantity * 100).round().toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              )
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
                  value: _quantity,
                  onChanged: (value) {
                    setState(() {
                      _quantity = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
                child: Center(
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Complete',
                      style: TextStyle(color: Colors.red),
                    )),
                  ),
                ),
                onTap: () {
                  if (_formkey.currentState.validate()) {
                    if (_value == 0) {
                      setState(() {
                        _error = 'Your Product quantity cannot be 0';
                      });
                    } else {
                      print(_productName);
                      print(_productPrice);
                      print(_productCategory);
                      print(_quantity * 100);
                      print(_value * 100);

                      // PageTransition(
                      //     type: PageTransitionType.leftToRight,
                      //     child: SuccessProduct());
                    }
                  }
                }),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
