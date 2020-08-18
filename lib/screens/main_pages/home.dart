import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/cart.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/main_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SignupNotifier _signupNotifier;
  dynamic dataInstance;

  List _categories = [];
  List _productName = [];
  List _productPrice = [];
  List _productImage = [];
  List _productQuantity = [];
  List _packQuantity = [];
  List _productId = [];
  List _productPackPrice = [];
  List _objects = [];
  bool newvalue = false;
  List<Map<String, dynamic>> items = [];
  List _prices = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    AddProductToCart _addProduct = Provider.of<AddProductToCart>(context);
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);

    final dbRef = FirebaseDatabase.instance; //firebase database reference
    dbRef.setPersistenceEnabled(true);
    dbRef.setPersistenceCacheSizeBytes(10000000);
    final databaseInstance = dbRef.reference();
    databaseInstance.keepSynced(true);
    final firebaseDb = databaseInstance
        .reference()
        .child('inventories')
        .orderByKey()
        .equalTo(_signupNotifier.firebaseId);

    return WillPopScope(
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login())),
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(120.0), // here the desired height
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
                          height: 35,
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCart()));
                        },
                      )),
                  GestureDetector(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 10, top: 5, left: 170),
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
                                  _addProduct.listOfQuantity.isEmpty
                                      ? '0'
                                      : _addProduct.listOfQuantity
                                          .reduce((a, b) => a + b)
                                          .toString(),
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
                      _addProduct.increment();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: firebaseDb.onValue,
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasData) {
                      _categories.clear();
                      _productName.clear();
                      DataSnapshot dataValues = snapshot.data.snapshot;
                      Map<dynamic, dynamic> values =
                          dataValues.value['${_signupNotifier.firebaseId}'];
                      values.forEach((key, values) {
                        print(values['products']?.map((value) {
                              _categories.add(value['name']);
                              _productId.add(value['id']);
                              print(value['product_image'].map((value) {
                                _productImage.add(value['image_link']);
                              }));

                              _productQuantity
                                  .add(value['product_unit']['quantity']);
                              _packQuantity
                                  .add(value['product_pack']['quantity']);
                              _productPrice.add(value['product_unit']['price']);
                              _productPackPrice
                                  .add(value['product_pack']['price']);
                            }) ??
                            '[]');
                      });

                      return Expanded(
                        child: GridView.builder(
                          itemCount: _categories.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (itemWidth / itemHeight),
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return new Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                child: Card(
                                  color: Colors.grey[100],
                                  child: Column(
                                    children: <Widget>[
                                      Image.network(
                                        _productImage[index],
                                        width: 150,
                                        height: 60,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 2,
                                                    color: Colors.grey[200]))),
                                        child: Center(
                                          child: Text(
                                            _categories[index],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 2,
                                                    color: Colors.grey[200]))),
                                        child: Center(
                                          child: Text(
                                            '${_productQuantity[index]} Units ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 2,
                                                    color: Colors.grey[200]))),
                                        child: Center(
                                          child: Text(
                                              '${_packQuantity[index]} pack',
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 2,
                                                        color:
                                                            Colors.grey[200]))),
                                            child: Center(
                                              child: Text(
                                                '${_productPrice[index]}/Units',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 2,
                                                        color:
                                                            Colors.grey[200]))),
                                            child: Center(
                                              child: Text(
                                                '${_productPackPrice[index]}/Pack',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  if (_productPackPrice[index] == 0) {
                                    _addProduct.addToCart(
                                        _productId[index],
                                        _categories[index].toString(),
                                        int.parse(
                                            _productPrice[index].toString()),
                                        int.parse(
                                          _productPackPrice[index].toString(),
                                        ),
                                        items);
                                    DialogBoxes().unitProduct(context);
                                  } else {
                                    // send pack to the dialog page
                                    _addProduct.addToCart(
                                        _productId[index],
                                        _categories[index].toString(),
                                        int.parse(
                                            _productPrice[index].toString()),
                                        int.parse(
                                          _productPackPrice[index].toString(),
                                        ),
                                        items);
                                    DialogBoxes().packProduct(context);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Text(
                        'You don\'t have any product yet. \n Go to the product page to add');
                  })
            ],
          )),
    );
  }
}
