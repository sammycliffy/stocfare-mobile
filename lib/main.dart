import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/intro_pages/splashscreen.dart';
import 'package:stockfare_mobile/sqlcool_database/database_schema.dart';

DatabaseSchema databaseSchema = DatabaseSchema();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  databaseSchema.initDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SignupNotifier>(
          create: (_) => SignupNotifier(),
        ),
        ChangeNotifierProvider<AddProductToCart>(
          create: (_) => AddProductToCart(),
        ),
        ChangeNotifierProvider<AddProductNotifier>(
          create: (_) => AddProductNotifier(),
        )
      ],
      child: MaterialApp(
          home: SplashScreen(),
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            canvasColor: Colors.white,
            brightness: Brightness.light,
            primaryColor: Hexcolor('#c80815'),
            accentColor: Hexcolor('#FF7781'),
            fontFamily: 'Mukta',
            dividerColor: Colors.black,
            hintColor: Colors.grey,
            focusColor: Colors.black,
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Mukta'),
              headline6: TextStyle(fontSize: 18.0, color: Colors.black),
              bodyText2: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Mukta',
                color: Colors.black,
              ),
            ),
          )),
    ),
  );
}
