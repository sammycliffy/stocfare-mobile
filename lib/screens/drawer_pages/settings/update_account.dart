import 'package:flutter/material.dart';

class UpdateAccount extends StatefulWidget {
  @override
  _UpdateAccountState createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Update Account')),
      body: Form(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (val) => setState(() {
                password = val;
              }),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon:
                    Icon(Icons.person, color: Theme.of(context).accentColor),
                hintText: 'First Name',
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
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (val) => setState(() {
                password = val;
              }),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon:
                    Icon(Icons.person, color: Theme.of(context).accentColor),
                hintText: 'Last Name',
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
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (val) => setState(() {
                password = val;
              }),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon: Icon(Icons.alternate_email,
                    color: Theme.of(context).accentColor),
                hintText: 'Email',
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
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (val) => setState(() {
                password = val;
              }),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon: Icon(Icons.phone_android,
                    color: Theme.of(context).accentColor),
                hintText: 'Phone',
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
            height: 20,
          ),
          GestureDetector(
              child: Center(
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(color: Colors.red, width: 3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              onTap: () async {}),
        ],
      )),
    );
  }
}
