import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class BarcodePageProduct extends StatefulWidget {
  @override
  _BarcodePageProductState createState() => _BarcodePageProductState();
}

class _BarcodePageProductState extends State<BarcodePageProduct> {
  String _scanBarcode = 'Unknown';
  File _image;
  bool loading = false;
  ProductServices _productServices = ProductServices();
  final picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;
  ActivitiesServices _activitiesServices = ActivitiesServices();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
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
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Add Image & Barcode')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ])),
              SizedBox(
                height: 60,
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
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ])),
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
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                    ),
                  ),
                  onTap: () async {
                    _activitiesServices.checkForInternet().then((value) async {
                      if (value == true) {
                        DialogBoxes().loading(context);

                        if (_image == null) {
                          setState(() {
                            _error = 'You must add product image';
                            _displaySnackBar(context);
                          });
                        } else {
                          List<int> imageBytes = _image.readAsBytesSync();
                          String base64Image = base64.encode(imageBytes);
                          dynamic result = await _productServices
                              .addProductToCategory(
                                  _addProduct.unitproductName,
                                  _addProduct.unitproductPrice,
                                  _addProduct.unitproductQuantity,
                                  _addProduct.unitLimit,
                                  _addProduct.packProductPrice,
                                  _addProduct.packQuantity,
                                  _addProduct.packLimit,
                                  _scanBarcode,
                                  _addProduct.productDescription,
                                  base64Image,
                                  _addProduct.productDiscount,
                                  _addProduct.productWeight,
                                  _addProduct.data,
                                  _addProduct.categoryId)
                              .timeout(Duration(seconds: 10),
                                  onTimeout: () => null);

                          if (result != 200) {
                            Navigator.pop(context);
                            setState(() {
                              result == null
                                  ? _error =
                                      'Opps! Error occured, please try again.'
                                  : _error = result.toString();
                              _displaySnackBar(context);
                            });
                          } else {
                            Navigator.pop(context);
                            DialogBoxes().success(context);
                          }
                        }
                      } else {
                        setState(() {
                          loading = false;
                          _error = 'Check your internet connection';
                          _displaySnackBar(context);
                        });
                      }
                    });
                  }),
              SizedBox(
                height: 50,
              ),
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
