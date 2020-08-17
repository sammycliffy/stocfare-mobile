import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/main_pages/all_products_list/checkout.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';

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
  static List _price = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addProduct = Provider.of<AddProductToCart>(context, listen: false);
      print(_addProduct.items.map((value) {
        setState(() {
          _prices.add(value['\'price\'']);
          _names.add(value['\'name\'']);
          _quantity.add(value['\'totalQuantity\'']);
          _type.add(value['\'type\'']);
          _price.add(value['\'price\'']);
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
                      '${_items.length} Products',
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
                        _clear();
                      });
                    },
                    child: Text('Empty'))
              ],
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: _items.length,
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
                                _names[index].toString().substring(
                                    1, _names[index].toString().length - 1),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                _quantity[index].toString() +
                                    ' ' +
                                    _type[index].toString().substring(
                                        1, _type[index].toString().length - 1),
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
                                    setState(() {
                                      _clearIndex(index);
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
            RaisedButton(
              color: Colors.black,
              onPressed: () {
                _addProduct.addPrice(_prices.reduce((a, b) => a + b));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckoutPage()));
              },
              child: Text(
                'Check out',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ));
  }

  _clear() {
    _addProduct.addProduct(0);
    _addProduct.items.clear();
    _addProduct.countItem.clear();
    _addProduct.addQuantity(0);
    _names.clear();
    _prices.clear();
    _names.clear();
    _quantity.clear();
    _type.clear();
    _price.clear();
  }

  _clearIndex(int index) {
    _addProduct.items.removeAt(index);
    _addProduct.listOfQuantity.clear();
    _names.removeAt(index);
    _prices.removeAt(index);
    _quantity.removeAt(index);
    _type.removeAt(index);
    _price.removeAt(index);
  }
}
