import 'dart:io';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/main_pages/common_widget/loader.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class BarcodePage extends StatefulWidget {
  @override
  _BarcodePageState createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  String _barcode;
  File _image;

  bool loading = false;
  ProductServices _productServices = ProductServices();
  final picker = ImagePicker();

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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProduct = Provider.of<AddProductNotifier>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: loading
            ? Loading()
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: Text(
                      'Add Image & Barcode',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                        child: Column(children: [
                      InkWell(
                        child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Icon(
                              Icons.assessment,
                              color: Colors.red,
                              size: 70,
                            )),
                        onTap: () {
                          getBarcode();
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
                            child: _barcode == null
                                ? Text('Barcode will show here',
                                    style: TextStyle(color: Colors.grey))
                                : Text(
                                    _barcode,
                                    style: TextStyle(color: Colors.black),
                                  )),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                        'Add Barcode',
                        style: TextStyle(color: Colors.red),
                      ),
                    ])),
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                        child: Column(children: [
                      InkWell(
                        child: _image == null
                            ? Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: Icon(Icons.add_a_photo,
                                    size: 50, color: Colors.red))
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
                        style: TextStyle(color: Colors.red),
                      ),
                    ])),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                        child: Center(
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(color: Colors.red, width: 3),
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
                          setState(() {
                            loading = true;
                          });
                          List<int> imageBytes = _image.readAsBytesSync();
                          String base64Image = base64.encode(imageBytes);
                          dynamic result = _productServices.productAddition(
                              _addProduct.productCategory,
                              _addProduct.productName,
                              _addProduct.productPrice,
                              _addProduct.productQuantity,
                              _addProduct.quantityAlert,
                              _barcode,
                              _addProduct.productDescription,
                              base64Image);

                          if (result == null) {
                            setState(() {
                              loading = false;
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavigationPage()));
                          }
                        }),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ));
  }
}
