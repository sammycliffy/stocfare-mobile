import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String dropdownValue = 'Cash';
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('Check out')),
        body: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Total Products',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    width: 50,
                  ),
                  Text('15', style: Theme.of(context).textTheme.headline6)
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Payment Method',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    width: 50,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    underline: Container(
                      height: 4,
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Cash',
                      'Check',
                      'Transfer',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Discount',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                      width: 80,
                      child: TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter quantity' : null,
                        onChanged: (val) => setState(() {
                          quantity = int.parse(val);
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
                      )),
                ],
              ),
              SizedBox(height: 20),
              Form(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 40),
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (input) =>
                            input.isEmpty ? "Enter your password" : null,
                        onChanged: (val) => setState(() {}),
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
                          prefixIcon: Icon(Icons.lock_open,
                              color: Theme.of(context).accentColor),
                          hintText: 'Enter password',
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
              )
            ],
          ),
        ));
  }
}
