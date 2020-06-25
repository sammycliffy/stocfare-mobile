import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'intro_pages/splashscreen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AddProductToCart(),
    child: MaterialApp(
      home: SplashScreen(),
    ),
  ));
}
