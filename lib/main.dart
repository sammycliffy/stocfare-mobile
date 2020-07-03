import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'intro_pages/splashscreen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AddProductToCart(),
    child: MaterialApp(
        home: SplashScreen(),
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          accentColor: Hexcolor('#FF5E69'),
          fontFamily: 'Mukta',
          dividerColor: Colors.black,
          hintColor: Hexcolor('#FF5E69'),
          focusColor: Colors.black,
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.black),
            headline6: TextStyle(
                fontSize: 36.0,
                fontStyle: FontStyle.italic,
                backgroundColor: Colors.black),
            bodyText2: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Mukta',
              color: Colors.black,
            ),
          ),
        )),
  ));
}
