import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
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
        });
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    AddProductToCart _addProduct = Provider.of<AddProductToCart>(context);
    List _items = _addProduct.items;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;
    final double itemWidth = size.width / 2;
    return Scaffold(
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        _prices.isEmpty
                            ? '0'
                            : _prices
                                .reduce((a, b) => a + b)
                                .toString(), //add the prices in the _prices list
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor))
                  ],
                ),
                RaisedButton(
                    onPressed: () {
                      setState(() {
                        _addProduct.items.clear();
                        _prices.clear();
                        // _addProduct.quantityToSell.clear();
                      });
                    },
                    child: Text('Empty'))
              ],
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: _addProduct.items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (itemWidth / itemHeight),
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                _names[index].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                _quantity[index].toString() +
                                    ' ' +
                                    _type[index].toString(),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              Text(
                                _prices[index].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Theme.of(context).primaryColor),
                                  onPressed: () {
                                    _addProduct.items.removeAt(index);
                                    setState(() {
                                      _names.removeAt(index);
                                      _prices.removeAt(index);
                                      _quantity.removeAt(index);
                                      _type.removeAt(index);
                                    });
                                  })
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    );
                  }),
            ),
            ButtonTheme(
              minWidth: 200.0,
              height: 50.0,
              child: RaisedButton(
                color: Colors.black,
                onPressed: () {
                  _addProduct.setPrice(_prices.reduce((a, b) => a + b));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckoutPage()));
                },
                child: Text(
                  'Check out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ));
  }
}
