import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/sales_pages/checkout.dart';

class AddCart extends StatefulWidget {
  @override
  _AddCartState createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  AddProductToCart _addProduct;
  static List _prices = [];
  static List _names = [];
  static List _quantity = [];
  static List _type = [];
  static List _id = [];
  var controller = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');

  @override
  void initState() {
    _prices.clear();
    _names.clear();
    _type.clear();
    _quantity.clear();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addProduct = Provider.of<AddProductToCart>(context, listen: false);
      print(_addProduct.items);
      print(_addProduct.items.map((value) {
        setState(() {
          _prices.add(value['totalCost']);
          _names.add(value['name']);
          _quantity.add(value['totalQuantity']);
          _type.add(value['type']);
          _id.add(value['id']);
        });
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    AddProductToCart _addProduct = Provider.of<AddProductToCart>(context);
    _addProduct.addTotal(_prices.isEmpty ? 0 : _prices.reduce((a, b) => a + b));
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    var controller = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    List _items = _addProduct.items;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;
    final double itemWidth = size.width / 2;
    controller.updateValue(
        _prices.isEmpty ? 0.0 : _prices.reduce((a, b) => a + b).toDouble());
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
            Colors.red[200],
            Colors.white,
          ],
              stops: [
            0.0,
            1.0
          ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.repeated)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            title: Text('Cart'),
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '${_addProduct.items.length} Products',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(controller.text, //add the prices in the _prices list
                          style: TextStyle(
                              fontSize: 18, color: Hexcolor('#40A099')))
                    ],
                  ),
                  RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          _addProduct.items.clear();
                          _prices.clear();
                          _addProduct.quantityToSell.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigationPage()));
                        });
                      },
                      child: Text(
                        'Empty',
                        style: TextStyle(color: Colors.red[800]),
                      ))
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _addProduct.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Card(
                            child: ListTile(
                              leading: Image.asset('assets/images/goods.png'),
                              title: Text(
                                _names?.elementAt(index).toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    _quantity[index].toString() +
                                        ' ' +
                                        _type[index].toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                  Text(
                                    _prices[index].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.blue[400]),
                                  onPressed: () {
                                    _addProduct.quantityToSell.clear();
                                    _addProduct.quantityToSell.add(_id);
                                    _addProduct.items.removeAt(index);
                                    setState(() {
                                      _names.removeAt(index);
                                      _prices.removeAt(index);
                                      _quantity.removeAt(index);
                                      _type.removeAt(index);
                                    });
                                  }),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.blue[700],
                  onPressed: () {
                    _addProduct.setPrice(_prices.reduce((a, b) => a + b));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutPage()));
                  },
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          )),
    );
  }
}
