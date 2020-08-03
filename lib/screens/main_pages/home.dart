import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlcool/sqlcool.dart';
import 'package:stockfare_mobile/models/db_model.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/main_app_bar.dart';
import 'package:stockfare_mobile/sqlcool_database/database_schema.dart';

class _PageSelectBlocState extends State<PageSelectBloc> {
  DatabaseSchema databaseSchema = DatabaseSchema();
  Future<DataModel> _productList;
  List _categories = [];
  List _productName = [];
  List _productPrice = [];
  List _productImage = [];
  List _productQuantity = [];
  List _productId = [];
  List _productPack = [];

  @override
  void initState() {
    super.initState();
    _productList = databaseSchema.retrieveDatabase();
    _productList.then((value) => print(value.databaseModel.map((e) {
          _categories.add(e.category);
          _productName.add(e.productName);
        })));
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    AddProductToCart addProduct = Provider.of<AddProductToCart>(context);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0), // here the desired height
            child: MainAppBar.appBarFunction(context, 'Dashboard')),
        drawer: DrawerPage(),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 18,
                    ),
                    child: InkWell(
                      child: Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text('Check out',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      onTap: () {},
                    )),
                GestureDetector(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, top: 5, left: 120),
                    child: Stack(
                      children: [
                        Icon(Icons.shopping_cart,
                            size: 30, color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: Container(
                            width: 40,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black),
                            child: Center(
                              child: Text(
                                // addProduct.product.toString(),
                                '0',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    // _checkoutDialog(context);
                  },
                ),
              ],
            ),
            FutureBuilder(
                future: _productList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: _categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 2 : 3),
                        itemBuilder: (BuildContext context, int index) {
                          return new Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Card(
                                color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Image.asset(
                                      'assets/images/laptop.png',
                                      width: 80,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      _productName[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).accentColor),
                                        child: Center(
                                            child: Text(
                                          '1900',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ))),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Text('No Data');
                })
          ],
        ));
  }
}

class PageSelectBloc extends StatefulWidget {
  @override
  _PageSelectBlocState createState() => _PageSelectBlocState();
}

//  childAspectRatio: (itemWidth / itemHeight),
//                         crossAxisCount: 3,
