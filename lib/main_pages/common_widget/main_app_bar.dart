import 'package:flutter/material.dart';

class MainAppBar {
  static appBarFunction() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.red),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Image.asset(
            'assets/images/logo.png',
            width: 25,
            height: 25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15, top: 10),
          child: Stack(
            children: [
              Icon(Icons.notifications, size: 40, color: Colors.red),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '12',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              )
            ],
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
