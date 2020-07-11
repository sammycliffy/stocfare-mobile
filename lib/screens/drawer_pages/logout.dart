import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
              child:
                  Image.asset('assets/images/logo.png', width: 40, height: 40)),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'Stockfare',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text('Hey! Enter your password to continue',
                style: TextStyle(
                  fontSize: 14,
                )),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              validator: (input) =>
                  input.isEmpty ? "Enter your password" : null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon:
                    Icon(Icons.lock_open, color: Theme.of(context).accentColor),
                hintText: 'Enter password',
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
            height: 30,
          ),
          GestureDetector(
              child: Center(
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                      child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              onTap: () async {}),
        ],
      ),
    );
  }
}
