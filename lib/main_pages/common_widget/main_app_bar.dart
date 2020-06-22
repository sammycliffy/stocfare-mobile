import 'package:flutter/material.dart';

class MainAppBar {
  static appBarFunction() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.red),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 100),
          child: Image.asset(
            'assets/images/logo.png',
            width: 25,
            height: 25,
          ),
        ),
        Column(children: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: ClipOval(
              child: Image.asset('assets/images/avatar.png',
                  height: 40, width: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(
              'Hi Samuel',
              style: TextStyle(color: Colors.red),
            ),
          )
        ])
      ],
    );
  }
}
