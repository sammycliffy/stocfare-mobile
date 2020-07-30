import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/intro_pages/add_single_products/barcode_image.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/edit_image_barcode.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
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

  bool loading = false;
  ProductServices _productServices = ProductServices();

  Future<ProductList> _productList;
  AddProductNotifier _addProductNotifier;

  List _categories = [];
  List _productCount = [];
  List _productName = [];
  List _productPrice = [];
  List _productImage = [];
  List _productQuantity = [];
  List _productId = [];
  List _productPackQuantity = [];
  List _productPackPrice = [];
  List _productPackLimit = [];
  List _description = [];
  List _unitLimitEdit = [];
  bool editProduct = false;
  bool deleteProduct = false;
  List<bool> checkBox = [];
  List deleteItem = [];

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
        _productName.add(name.name);
        checkBox.add(false);
        _description.add(name.description);
        _unitLimitEdit.add(name.productUnit.limit);
        _productId.add(name.id);
        _productPrice.add(name.productUnit.price);
        _productImage.add(name.productImage[0].imageLink);
        _productQuantity.add(name.productUnit.quantity);

        _productPackQuantity.add(name.productPack.quantity);
        _productPackPrice.add(name.productPack.price);
        _productPackLimit.add(name.productPack.limit);

        return name.name;
      }));

      print(value.results.map((category) {
        setState(() {
          _categories.add(category.name);
          _productCount.add(category.productCount);
        });
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProduct = Provider.of<AddProductNotifier>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Edit Product Page'),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditImageBarcode()));
              },
              child: Text(
                'Add Image & Barcode',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              color: Colors.white,
            )
          ],
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
                                  hintText: _productName[
                                          _addProductNotifier.productIndex] +
                                      '    (Product Name)',
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
                                  hintText: _productPrice[
                                              _addProductNotifier.productIndex]
                                          .toString() +
                                      ' (Price)',
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
                                      hintText: _productQuantity[
                                                  _addProductNotifier
                                                      .productIndex]
                                              .toString() +
                                          ' (Quantity)',
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
                                    keyboardType: TextInputType.text,
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
                                      hintText: _unitLimitEdit[
                                                  _addProductNotifier
                                                      .productIndex]
                                              .toString() +
                                          ' (Limit)',
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
                                validator: (input) => input.isEmpty
                                    ? "Enter Product Description"
                                    : null,
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
                                  hintText: _description[
                                          _addProductNotifier.productIndex] +
                                      '    (Product Description)'.toString(),
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 50,
                                  ),
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
                                ),
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
                                        height: 30,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 150.0),
                                        child: Text('Add Colors',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .primaryColor)),
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
                                          // inputFormatters: [controller],
                                          // controller: textEditingController,
                                          keyboardType: TextInputType.number,

                                          onChanged: (val) => setState(() {
                                            _colorQuantity = int.parse(val);
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
                                  )
                                : SizedBox(),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
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
                                  hintText: _productPackPrice[
                                              _addProductNotifier.productIndex]
                                          .toString() +
                                      ' (Pack Price)',
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
                                      hintText: _productPackQuantity[
                                                  _addProductNotifier
                                                      .productIndex]
                                              .toString() +
                                          ' (Pack Quantity)',
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
                                      hintText: _productPackLimit[
                                                  _addProductNotifier
                                                      .productIndex]
                                              .toString() +
                                          ' (Pack Limit)',
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
                                  print(_productCategory);
                                  print(_unitProductName);
                                  print(_productDescription);
                                  print(_unitLimit);
                                  print(_unitQuantity);
                                  print(_unitProductPrice);
                                  print(_packProductPrice);
                                  print(_packQuantity);
                                  print(_packLimit);

                                  // if (_formKey.currentState.validate()) {

                                  //   // _addProduct.setFirstProduct(
                                  //   //     _productCategory,
                                  //   //     _unitProductName,
                                  //   //     _unitLimit * 100,
                                  //   //     _unitProductPrice,
                                  //   //     _productDescription);

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             BarcodePage()));
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
}
