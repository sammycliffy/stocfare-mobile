import 'package:flutter/material.dart';

class AddCart extends StatefulWidget {
  @override
  _AddCartState createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart'), actions: [
        Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Row(
            children: <Widget>[Icon(Icons.add), Text('Add Product')],
          ),
        )
      ]),
    );
  }
}
