import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/db_model.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/cart.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/main_app_bar.dart';
import 'package:stockfare_mobile/sqlcool_database/database_schema.dart';

class _HomePageState extends State<HomePage> {
  DatabaseSchema databaseSchema = DatabaseSchema();
  Future<DataModel> _productList;
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
  List items = [];
  List<Map<String, dynamic>> type = [];
  List daniel = [];
  @override
  void initState() {
    super.initState();
    _productList = databaseSchema.retrieveDatabase();
    _productList.then((value) => print(value.databaseModel.map((e) {
          _categories.add(e.category);
          _productName.add(e.productName);
          _productQuantity.add(e.productQuantity);
          _packQuantity.add(e.productPackQuantity);
          _productPrice.add(e.productUnitPrice);
          _productPackPrice.add(e.productPackPrice);
          _productImage.add(e.imageLink);
          _productId.add(e.productId);
        })));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;
    final double itemWidth = size.width / 2;
    AddProductToCart _addProduct = Provider.of<AddProductToCart>(context);
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
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AddCart()));
                      },
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
                                _addProduct.items.length.toString(),
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
                    // _addProduct.increment();
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
                            childAspectRatio: (itemWidth / itemHeight),
                            crossAxisCount: 3),
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
                                    Image.network(
                                      _productImage[index],
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${_productQuantity[index]} Units | ${_packQuantity[index]} pack ',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${_productPrice[index]}/Units',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          '${_productPackPrice[index]}/Pack',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                if (_productPackPrice[index] == '0') {
                                  int count = 0;
                                  setState(() {
                                    items.add(_productId[index]);
                                    var map = Map();

                                    items.forEach((element) {
                                      if (!map.containsKey(element)) {
                                        map[element] = 1;
                                      } else {
                                        map[element] += 1;
                                      }
                                    });
                                    dynamic id = map[_productId[index]];
                                    if (type.length == 0) {
                                      type.add({
                                        '\'totalQuantity\'': id,
                                        '\'type\'': '\'unit\'',
                                        '\'id\'': '\'${_productId[index]}\'',
                                      });
                                    } else {
                                      for (var map in type) {
                                        if (map.containsKey('\'id\'')) {
                                          if (map['\'id\''] ==
                                              '\'${_productId[index]}\'') {
                                            map['\'totalQuantity\''] = id;
                                            print('it has');
                                          } else {
                                            type.add({
                                              '\'totalQuantity\'': id,
                                              '\'type\'': '\'unit\'',
                                              '\'id\'':
                                                  '\'${_productId[index]}\'',
                                            });
                                            break;
                                          }
                                        } else {
                                          type.add({
                                            '\'totalQuantity\'': id,
                                            '\'type\'': '\'unit\'',
                                            '\'id\'':
                                                '\'${_productId[index]}\'',
                                          });
                                        }
                                      }
                                    }
                                    // dynamic id = map[_productId[index]];
                                    // type.add({
                                    //   '\'totalQuantity\'': id,
                                    //   '\'type\'': '\'unit\'',
                                    //   '\'id\'': '\'${_productId[index]}\'',
                                    // });
                                  });
                                  print(type);

                                  _addProduct.addItems(items, type);
                                } else {
                                  _addProduct.addToCart(
                                      _productName[index],
                                      int.parse(_productPrice[index]),
                                      int.parse(
                                        _productPackPrice[index],
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
                  return Text('No Data');
                })
          ],
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}
