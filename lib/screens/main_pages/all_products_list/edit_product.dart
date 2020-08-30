import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/color_models.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _colorFormKey = GlobalKey<FormState>();
  String _productCategory;
  String _unitProductName;
  String _productDescription;
  int _unitProductPrice = 0;
  int _unitQuantity = 0;
  int _unitLimit = 0;
  bool addExtraDetails = false;
  int _packProductPrice;
  int _packQuantity;
  int _packLimit;
  int _productDiscount = 0;
  int _productWeight = 0;
  String _colorName;
  int _colorQuantity;
  int _colorLimit;
  int _productCount;
  final List<String> color = <String>[];
  final List<ColorDataModel> _data = [];
  var controller = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');
  var controller1 = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');
  bool loading = false;
  ProductServices _productServices = ProductServices();

  Future<ProductList> _productList;
  AddProductNotifier _addProductNotifier;

  List _categories = [];
  bool editProduct = false;
  bool deleteProduct = false;
  List<bool> checkBox = [];
  List deleteItem = [];
  String _scanBarcode = 'Unknown';
  String _categoryId;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addProductNotifier =
          Provider.of<AddProductNotifier>(context, listen: false);
    });
    _productList = _productServices.getAllProducts();
    _productList.then((value) {
      print(
          value.results[_addProductNotifier.categoryIndex].products.map((name) {
        _unitProductName = name.name;
        _categoryId = name.id;
        checkBox.add(false);
        _productDescription = name.description;
        _unitLimit = name.productUnit.limit;
        _unitProductPrice = name.productUnit.price;
        _unitQuantity = name.productUnit.quantity;
        _packProductPrice = name.productPack.price;
        _packQuantity = name.productPack.quantity;
        _packLimit = name.productPack.limit;
      }));

      print(value.results.map((category) {
        setState(() {
          _categories.add(category.name);
          _productCount = category.productCount;
        });
      }));
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
        appBar: AppBar(
          title: Text('Edit Product Page'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              FutureBuilder<ProductList>(
                  future: _productList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                onChanged: (val) => setState(() {
                                  _productCategory = val;
                                }),
                                readOnly: true,
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
                                  hintText: _categories[
                                          _addProductNotifier.productIndex] +
                                      ' (Category Name)'.toString(),
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
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                validator: (input) => input.isEmpty
                                    ? "Enter Product Name "
                                    : null,
                                onChanged: (val) => setState(() {
                                  _unitProductName = val;
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
                                  labelText:
                                      _unitProductName + '    (Product Name)',
                                  hintText: 'Enter product Name',
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
                            Padding(
                              padding: const EdgeInsets.only(right: 210),
                              child: Text(
                                'Enter Price',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(right: 210),
                              child: Text('Unit Details',
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                controller: controller,
                                keyboardType: TextInputType.text,
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
                                  labelText:
                                      _unitProductPrice.toString() + ' (Price)',
                                  hintText: 'Enter price',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 150,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (_unitQuantity < _unitLimit) {
                                        return 'Quantity cannot be < limit';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) => setState(() {
                                      _unitQuantity = int.parse(val);
                                    }),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(12),
                                      labelStyle: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.2))),
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.7)),
                                      labelText: _unitQuantity.toString(),
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
                                SizedBox(width: 5),
                                SizedBox(
                                  width: 150,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (val) => setState(() {
                                      _unitLimit = int.parse(val);
                                    }),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(12),
                                      labelStyle: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.2))),
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.7)),
                                      labelText:
                                          _unitLimit.toString() + ' (Limit)',
                                      hintText: 'Limit',
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
                            SizedBox(height: 10),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 200),
                                child: Text('What is this?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              onTap: () {
                                _productLimit(context);
                              },
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                onChanged: (val) => setState(() {
                                  _productDescription = val;
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
                                  labelText: _productDescription.toString(),
                                  hintText: 'product Description',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
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
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            addExtraDetails = true;
                                          });
                                        },
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                                            labelText: 'Product Discounts (%)',
                                            hintText: 'Product Discount',
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
                                            labelText: 'Product Weight in (Kg)',
                                            hintText: 'Product Weight',
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
                                        padding:
                                            const EdgeInsets.only(right: 150.0),
                                        child: Text('Add Colors',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
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
                                      color.length == 0
                                          ? SizedBox()
                                          : Container(
                                              height: 150,
                                              width: 320,
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  itemCount: color.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              bottom: 5),
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
                                                              Text(
                                                                  color[index]),
                                                              IconButton(
                                                                  icon: Icon(Icons
                                                                      .cancel),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      color.remove(
                                                                          color[
                                                                              index]);
                                                                    });
                                                                  })
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                      SizedBox(height: 20),
                                      Form(
                                        key: _colorFormKey,
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 300,
                                              child: TextFormField(
                                                // inputFormatters: [controller],
                                                // controller: textEditingController,
                                                keyboardType:
                                                    TextInputType.text,

                                                onChanged: (val) =>
                                                    setState(() {
                                                  _colorName = val;
                                                }),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(12),
                                                  labelStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .focusColor
                                                                  .withOpacity(
                                                                      0.2))),
                                                  hintStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .focusColor
                                                          .withOpacity(0.7)),
                                                  labelText: 'Color Name',
                                                  hintText: 'Color Name',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .focusColor
                                                                  .withOpacity(
                                                                      0.2))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .focusColor
                                                                  .withOpacity(
                                                                      0.5))),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            SizedBox(
                                              width: 300,
                                              child: TextFormField(
                                                // inputFormatters: [controller],
                                                // controller: textEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (val) {
                                                  if (int.parse(val) <
                                                      _colorLimit) {
                                                    return 'Quantity cannot be < limit';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (val) =>
                                                    setState(() {
                                                  _colorQuantity =
                                                      int.parse(val);
                                                }),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(12),
                                                  labelStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .focusColor
                                                                  .withOpacity(
                                                                      0.2))),
                                                  hintStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .focusColor
                                                          .withOpacity(0.7)),
                                                  labelText: 'Color Quantity',
                                                  hintText: 'Color Quantity',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .focusColor
                                                                  .withOpacity(
                                                                      0.2))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .focusColor
                                                                  .withOpacity(
                                                                      0.5))),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            SizedBox(
                                              width: 300,
                                              child: TextFormField(
                                                // inputFormatters: [controller],
                                                // controller: textEditingController,
                                                keyboardType:
                                                    TextInputType.number,

                                                onChanged: (val) =>
                                                    setState(() {
                                                  _colorLimit = int.parse(val);
                                                }),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(12),
                                                  labelStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .focusColor
                                                                  .withOpacity(
                                                                      0.2))),
                                                  hintStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .focusColor
                                                          .withOpacity(0.7)),
                                                  labelText: 'Color Limit',
                                                  hintText: 'Color limit',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .focusColor
                                                                  .withOpacity(
                                                                      0.2))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .focusColor
                                                                  .withOpacity(
                                                                      0.5))),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          if (_colorFormKey.currentState
                                              .validate()) {
                                            setState(() {
                                              color.add(
                                                  '$_colorName (Quantity: $_colorQuantity pcs)  (Limit: $_colorLimit pcs)');
                                            });
                                            ColorDataModel _colorData =
                                                ColorDataModel(
                                                    colorName: _colorName,
                                                    colorQuantity:
                                                        _colorQuantity,
                                                    colorLimit: _colorLimit);
                                            _data.add(_colorData);
                                          }
                                        },
                                        child: const Text('Add Color',
                                            style: TextStyle(fontSize: 20)),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                controller: controller1,
                                keyboardType: TextInputType.text,
                                onChanged: (val) => setState(() {
                                  _packProductPrice = int.parse(val);
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
                                  labelText: _packProductPrice.toString() +
                                      ' (Pack Price)',
                                  hintText: 'Pack Price',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 150,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (_packQuantity < _packLimit) {
                                        return 'Quantity cannot be < limit';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) => setState(() {
                                      _packQuantity = int.parse(val);
                                    }),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(12),
                                      labelStyle: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.2))),
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.7)),
                                      labelText: _packQuantity.toString() +
                                          ' (Pack Quantity)',
                                      hintText: 'Pack Quantity',
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
                                    keyboardType: TextInputType.text,
                                    onChanged: (val) => setState(() {
                                      _packLimit = int.parse(val);
                                    }),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(12),
                                      labelStyle: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.2))),
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.7)),
                                      labelText: _packLimit.toString() +
                                          ' (Pack Limit)',
                                      hintText: 'Pack Limit',
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
                              height: 60,
                            ),
                            Center(
                                child: Column(children: [
                              InkWell(
                                child: Container(
                                    width: 100,
                                    height: 100,
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
                                    border: Border.all(
                                        width: 2, color: Colors.grey)),
                                child: Center(
                                    child: _scanBarcode == null
                                        ? Text('Barcode will show here',
                                            style:
                                                TextStyle(color: Colors.grey))
                                        : Text(
                                            _scanBarcode,
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Text(
                                'Add Barcode',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ])),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                    DialogBoxes().loading(context);
                                    _productServices
                                        .editProduct(
                                            _unitProductName,
                                            controller.numberValue,
                                            _unitQuantity,
                                            _unitLimit,
                                            controller1.numberValue,
                                            _packQuantity,
                                            _packLimit,
                                            _scanBarcode,
                                            _productDescription,
                                            _productDiscount,
                                            _productWeight,
                                            _data,
                                            _categoryId)
                                        .then((value) {
                                      if (value == true) {
                                        Navigator.pop(context);
                                        DialogBoxes().success(context);
                                      } else {
                                        setState(() {
                                          _error = value.toString();
                                          _displaySnackBar(context);
                                        });
                                      }
                                    });
                                  }
                                }),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  })
            ],
          ),
        ));
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
