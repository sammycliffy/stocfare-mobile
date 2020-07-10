import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stockfare_mobile/main_pages/all_products_list/checkout.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/screens/intro_pages/addProducts.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/available.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/main_app_bar.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductServices _productServices = ProductServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddProductToCart addProduct = Provider.of<AddProductToCart>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: MainAppBar.appBarFunction(context, 'Dashboard')),
      drawer: DrawerPage(),
      body: Column(
        children: [
          // Container(
          //   height: 50,
          //   child: ListView.builder(
          //       itemCount: 20,
          //       // This next line does the trick.
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (BuildContext context, int index) {
          //         return FutureBuilder(
          //             future: futureProductList,
          //             builder: (context, snapshot) {
          //               return ListView.builder(
          //                   itemCount: int.parse(snapshot.data.count),
          //                   // This next line does the trick.
          //                   scrollDirection: Axis.horizontal,
          //                   itemBuilder: (BuildContext context, int index) {
          //                     return Container(
          //                       width: 100.0,
          //                       color: Colors.red,
          //                       child: Center(
          //                         child: Text(
          //                           'james',
          //                           style: TextStyle(color: Colors.white),
          //                         ),
          //                       ),
          //                     );
          //                   });
          //             });
          //       }),
          // ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, top: 5, left: 250),
              child: Stack(
                children: [
                  Icon(Icons.shopping_cart, size: 30, color: Colors.red),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Container(
                      width: 40,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red),
                      child: Center(
                        child: Text(
                          addProduct.product.toString(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              _checkoutDialog(context);
            },
          ),
          Expanded(child: ProductsAvailable())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Future<void> _checkoutDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        AddProductToCart addProduct = Provider.of<AddProductToCart>(context);
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Quantity',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(width: 50),
                  Text(
                    addProduct.product.toString(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        'Reset',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                    ),
                  ),
                  onTap: () {
                    addProduct.setProductValue(0);
                  }),
            ],
          )),
          actions: <Widget>[
            GestureDetector(
                child: Center(
                  child: Container(
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.green, width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Check out',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckoutPage()));
                }),
          ],
        );
      },
    );
  }
}