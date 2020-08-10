import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String dropdownValue = 'Cash';
  int quantity = 0;
  bool newvalue = false;
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    AddProductToCart addProduct = Provider.of<AddProductToCart>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Check out')),
        body: Padding(
          padding: const EdgeInsets.only(left: 50, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Total Products',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(
                      width: 80,
                    ),
                    Text(addProduct.items.length.toString(),
                        style: Theme.of(context).textTheme.headline6)
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Text('Total Price',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(
                      width: 110,
                    ),
                    Text(addProduct.prices.toString(),
                        style: Theme.of(context).textTheme.headline6)
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
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
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
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          // inputFormatters: [controller],
                          // controller: textEditingController,
                          keyboardType: TextInputType.number,
                          validator: (input) =>
                              input.isEmpty ? "Enter Product Price" : null,
                          onChanged: (val) => setState(() {}),
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
                            hintText: 'Tax',
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
                        width: 120,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (input) =>
                              input.isEmpty ? "Enter Quantity " : null,
                          onChanged: (val) => setState(() {}),
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
                            hintText: 'Change',
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
                ),
                SizedBox(height: 20),
                Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 40),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input.isEmpty ? "Customer name" : null,
                          onChanged: (val) => setState(() {}),
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
                            prefixIcon: Icon(Icons.person,
                                color: Theme.of(context).accentColor),
                            hintText: 'Customer name',
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
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 40),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input.isEmpty ? "Customer phone" : null,
                          onChanged: (val) => setState(() {}),
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
                            prefixIcon: Icon(Icons.phone_android,
                                color: Theme.of(context).accentColor),
                            hintText: 'Customer phone',
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
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 40),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) =>
                              input.isEmpty ? "Customer email" : null,
                          onChanged: (val) => setState(() {}),
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
                            prefixIcon: Icon(Icons.alternate_email,
                                color: Theme.of(context).accentColor),
                            hintText: 'Customer Email',
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
                      CheckboxListTile(
                        activeColor: Theme.of(context).primaryColor,
                        title: Text('Sold on Credit',
                            style: Theme.of(context).textTheme.headline6),
                        value: newvalue,
                        onChanged: (newValue) {
                          setState(() {
                            newvalue = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                      newvalue
                          ? _soldOnCredit(context)
                          : SizedBox(), // check of sold on credit is clicked
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          color: Colors.grey[100],
                          width: 300,
                          height: 120,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Tax', style: TextStyle(fontSize: 18)),
                                  SizedBox(
                                    width: 145,
                                  ),
                                  Text('0', style: TextStyle(fontSize: 18))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('You Owe',
                                      style: TextStyle(fontSize: 18)),
                                  SizedBox(
                                    width: 110,
                                  ),
                                  Text('0', style: TextStyle(fontSize: 18))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Total', style: TextStyle(fontSize: 23)),
                                  SizedBox(
                                    width: 140,
                                  ),
                                  Text('0', style: TextStyle(fontSize: 23))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 3),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: Text(
                                  'Checkout',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                              ),
                            ),
                            onTap: () {}),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _soldOnCredit(context) {
    return ListBody(children: [
      Padding(
        padding: const EdgeInsets.only(left: 5, right: 40),
        child: TextFormField(
          keyboardType: TextInputType.number,
          validator: (input) => input.isEmpty ? "Initial Deposit" : null,
          onChanged: (val) => setState(() {}),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2))),
            hintStyle:
                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
            hintText: 'Initial Deposit',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.5))),
          ),
          style: TextStyle(color: Colors.black),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        "${selectedDate.toLocal()}".split(' ')[0],
        style: Theme.of(context).textTheme.headline6,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: RaisedButton(
          onPressed: () => _selectDate(context),
          child: Text('Select Promised date'),
        ),
      )
    ]);
  }
}
