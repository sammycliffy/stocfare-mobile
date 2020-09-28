import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductPriceState createState() => _EditProductPriceState();
}

class _EditProductPriceState extends State<EditProduct> {
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
    return Scaffold(
        appBar: AppBar(title: Text('Edit Product')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _names.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_names[index], style: TextStyle(fontSize: 18)),
                          Text(_quantity[index].toString(),
                              style: TextStyle(fontSize: 18)),
                          Container(
                            height: 40,
                            width: 80,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: _prices[index].toString(),
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
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Center(
                child: RaisedButton(
              child: Text('Update'),
              onPressed: null,
            )),
            SizedBox(height: 50)
          ],
        ));
  }

  void sellUnitProduct(_productId, _productName, _productUnitPrice) {
    var map = Map();
    _addProduct.quantityToSell.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });

    bool _itemFound = false;
    int _index;
    for (var i = 0; i < _addProduct.items.length; i++) {
      if (_addProduct.items.length >= 1 &&
          _addProduct.items[i]['id'] == _productId) {
        _itemFound = true;
        _index = i;
        break;
      } else {
        print('Item Not Exists');
      }
    }
    if (_itemFound == true) {
      _addProduct.items[_index]['totalQuantity'] = (map[_productId]);
      _addProduct.items[_index]['totalCost'] =
          (map[_productId]) * _productUnitPrice;
    } else {
      _addProduct.items.add({
        'totalQuantity': map[_productId],
        'type': 'unit',
        'id': _productId,
        'totalCost': _productUnitPrice * (map[_productId]),
        'name': '$_productName',
        "colours": []
      });
    }
  }
}
