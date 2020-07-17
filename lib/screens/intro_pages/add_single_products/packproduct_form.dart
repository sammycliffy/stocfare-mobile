import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/intro_pages/add_single_products/barcode_image.dart';
import 'package:stockfare_mobile/screens/intro_pages/add_single_products/packproduct_form.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class AddPackPage extends StatefulWidget {
  @override
  _AddPackPageState createState() => _AddPackPageState();
}

class _AddPackPageState extends State<AddPackPage> {
  final _formKey = GlobalKey<FormState>();

  String _packProductName;

  int _packProductPrice = 0;
  int _packQuantity = 0;
  double _packLimit = 0;

  bool loading = false;
  ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProduct = Provider.of<AddProductNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Pack Product'),
        ),
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
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
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
                            keyboardType: TextInputType.text,
                            validator: (input) =>
                                input.isEmpty ? "Enter Quantity " : null,
                            onChanged: (val) => setState(() {
                              _packQuantity = int.parse(val);
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
                      height: 20,
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
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          overlayColor: Colors.red,
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 28.0),
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
                          if (_formKey.currentState.validate()) {
                            _addProduct.setPackProducts(_packProductName,
                                _packProductPrice, _packLimit, _packQuantity);
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
}
