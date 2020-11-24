import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/product_success.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class BarcodePage extends StatefulWidget {
  @override
  _BarcodePageState createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  ActivitiesServices _activitiesServices = ActivitiesServices();
  String _scanBarcode = 'Unknown';
  File _image;

  ProductServices _productServices = ProductServices();
  final picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
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
                      child: IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.barcode,
                          size: 100,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: null,
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
                  'Click box to scan barcode',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Text(
                  '(Optional)',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
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
                    _showPicker(context);
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
                Text(
                  '(Optional)',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
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
                      String noImage = await getImageFileFromAssets();
                      if (value == true) {
                        DialogBoxes().loading(context);
                        List<int> imageBytes;
                        String base64Image;
                        if (_image == null) {
                          base64Image = noImage;
                        } else {
                          imageBytes = _image.readAsBytesSync();
                          base64Image = base64.encode(imageBytes);
                        }
                        dynamic result = await _productServices
                            .productAddition(
                                _addProduct.productCategory,
                                _addProduct.unitproductName,
                                _addProduct.unitproductPrice,
                                _addProduct.unitCostPrice,
                                _addProduct.unitproductQuantity,
                                _addProduct.unitLimit,
                                _addProduct.packProductPrice,
                                _addProduct.packCostPrice,
                                _addProduct.packQuantity,
                                _addProduct.packLimit,
                                _scanBarcode,
                                _addProduct.productDescription,
                                base64Image,
                                _addProduct.productDiscount,
                                _addProduct.productWeight,
                                _addProduct.data)
                            .timeout(Duration(seconds: 25),
                                onTimeout: () => null);

                        if (result != 201) {
                          if (result == null) {
                            Navigator.pop(context);
                            setState(() {
                              _error = 'Opps! Error occured, please try again.';
                              _displaySnackBar(context);
                            });
                          } else if (result == false) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          } else {
                            Navigator.pop(context);
                            setState(() {
                              _error = result.toString();
                              _displaySnackBar(context);
                            });
                          }
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductSuccess()));
                        }
                      } else {
                        setState(() {
                          setState(() {
                            _error = 'Check your internet connection';
                            _displaySnackBar(context);
                          });
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

  Future<String> getImageFileFromAssets() async {
    final byteData = await rootBundle.load('assets/images/No-image.png');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/No-image.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    List<int> imageByte = file.readAsBytesSync();
    String base64Image = base64.encode(imageByte);
    return base64Image;
  }
}
