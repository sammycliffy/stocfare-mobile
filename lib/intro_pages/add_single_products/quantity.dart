import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/intro_pages/add_single_products/barcode_image.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';

class QuantityPage extends StatefulWidget {
  @override
  _QuantityPageState createState() => _QuantityPageState();
}

class _QuantityPageState extends State<QuantityPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _quantity = 0;
  double _value = 0;
  String _error;
  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProduct = Provider.of<AddProductNotifier>(context);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Center(
                child: Text(
              'Quantity',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 40),
            Container(
              width: 300,
              child: Text(
                'How many ${_addProduct.productName} do you have?',
                style: TextStyle(fontSize: 20),
              ),
            ),
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
            Flexible(
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.red),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                    child: Text(
                  (_quantity * 100).round().toString(),
                  style: TextStyle(color: Colors.red, fontSize: 20),
                )),
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 300,
              child: Text(
                'Tell us when to notify you',
                style: TextStyle(fontSize: 20),
              ),
            ),
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
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.red),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                    child: Text(
                  (_value * 100).round().toString(),
                  style: TextStyle(color: Colors.red, fontSize: 20),
                )),
              ),
            ),
            SizedBox(
              height: 80,
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
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  ),
                ),
                onTap: () {
                  if (_quantity == 0) {
                    setState(() {
                      setState(() {
                        _error = 'Your Product quantity cannot be 0';
                        _displaySnackBar(context);
                      });
                    });
                  } else {
                    _addProduct.setQuantity(
                        (_quantity * 100).round(), (_value * 100).round());

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BarcodePage()));
                  }
                }),
          ],
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
