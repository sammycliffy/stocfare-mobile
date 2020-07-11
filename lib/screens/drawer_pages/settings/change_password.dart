import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Change Password')),
        body: Form(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                onChanged: (val) => setState(() {
                  password = val;
                }),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  hintStyle: TextStyle(
                      color: Theme.of(context).focusColor.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.lock_open,
                      color: Theme.of(context).accentColor),
                  hintText: 'Old Password',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.5))),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                onChanged: (val) => setState(() {
                  password = val;
                }),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  hintStyle: TextStyle(
                      color: Theme.of(context).focusColor.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.lock_open,
                      color: Theme.of(context).accentColor),
                  hintText: 'New Password',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.5))),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                onChanged: (val) => setState(() {
                  password = val;
                }),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  hintStyle: TextStyle(
                      color: Theme.of(context).focusColor.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.lock_open,
                      color: Theme.of(context).accentColor),
                  hintText: 'Confirm Password',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.5))),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
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
                      'Change Password',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                onTap: () async {}),
          ],
        )));
  }
}
