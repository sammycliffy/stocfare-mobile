import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _unit = true;
  @override
  Widget build(BuildContext context) {
    AddProductToCart _addToCart = Provider.of<AddProductToCart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(' Product Details'),
        actions: [
          // IconButton(icon: Icon(Icons.edit), onPressed: () => ,)
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Center(
            child: CachedNetworkImage(
              width: 200,
              height: 150,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl: _addToCart.imageUrl,
            ),
          ),
          // Center(
          //   child: Image.asset(
          //     'assets/images/No-image.png',
          //     width: 350,
          //     height: 150,
          //     fit: BoxFit.contain,
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
                width: 350,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('Category:',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor)),
                        Text(_addToCart.categoryName,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        SizedBox(height: 20),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Product:',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor)),
                        Text(_addToCart.productName,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                )),
          ),

          (() {
            if (_unit == false) {
              return RaisedButton(
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _unit = true;
                  });
                },
                child: Text('Unit Details',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              );
            } else {
              return RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    _unit = false;
                  });
                },
                child: Text('Pack Details',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              );
            }
          }()),

          SizedBox(height: 10),
          _unit
              ? details(_addToCart.quantity, _addToCart.productUnitPrice,
                  _addToCart.unitLimit, 'Units')
              : details(_addToCart.packQuantity, _addToCart.packPrice,
                  _addToCart.packLimit, 'Pack'),
          SizedBox(height: 20),
          Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey[350],
              ))),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text('Descriptions:',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(_addToCart.description ?? 'None',
                style: TextStyle(
                  fontSize: 15,
                )),
          ),
        ],
      )),
    );
  }
}

details(unit, price, limit, type) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Quantity:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          Text('$unit $type',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.green))
        ],
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Price:    ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          Text('$price ',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.green))
        ],
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Limit:    ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          Text('$limit ',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.green))
        ],
      ),
    ],
  );
}
