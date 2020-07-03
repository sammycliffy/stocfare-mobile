import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MainAppBar {
  static appBarFunction() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.red),
      actions: [
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 15),
              child: Stack(
                children: [
                  Icon(Icons.notifications,
                      size: 30, color: Hexcolor('#5bbbeb')),
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
                          style: TextStyle(color: Hexcolor('#5bbbeb')),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
