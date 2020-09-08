import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/addProducts.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/edit_product.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class ProductListPage extends StatefulWidget {
  // final int customerIndex;
  // ProductListPage({Key key, @required this.customerIndex}) : super(key: key);
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<ProductList> _productList;
  AddProductNotifier _addProductNotifier;
  ProductServices _productServices = ProductServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List _productName = [];
  List _productPrice = [];
  List _productQuantity = [];
  List _packQuantity = [];
  List _productId = [];
  bool editProduct = false;
  bool deleteProduct = false;
  List<bool> checkBox = [];
  List<String> deleteItem = [];
  String _error;
  bool _search = false;

  @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   _addProductNotifier =
  //       Provider.of<AddProductNotifier>(context, listen: false);
  // });
  // _productList = _productServices.getAllProducts();
  // _productList.then((value) {
  //   _categoryId = value.results[_addProductNotifier.categoryIndex].id;
  //   print(
  //       value.results[_addProductNotifier.categoryIndex].products.map((name) {
  //     _productName.add(name.name);
  //     checkBox.add(false);
  //     _productId.add(name.id);
  //     _productPrice.add(name.productUnit.price);
  //     _productImage.add(name.productImage[0].imageLink);
  //     _productQuantity.add(name.productUnit.quantity);

  //     _productPack.add(name.productPack.quantity);
  //     return name.name;
  //   }));

  //   print(value.results.map((category) {
  //     setState(() {
  //       _categories.add(category.name);
  //       _productCount.add(category.productCount);
  //     });
  //   }));
  // });

  @override
  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    AddProductToCart _addToCart = Provider.of<AddProductToCart>(context);
    // int val = _addProduct.listOfQuantity.reduce((a, b) => a + b);

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
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
          title: StreamBuilder(
              stream: firebaseDb.onValue,
              builder: (context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.snapshot.value != null) {
                    DataSnapshot dataValues = snapshot.data.snapshot;
                    Map values =
                        dataValues.value['${_signupNotifier.firebaseId}']
                            ['${_addToCart.fireId}'];
                    return Text('${values['name']}'.toString());
                  }
                  return Text('Product Name');
                }
                return CircularProgressIndicator();
              }),
          actions: <Widget>[
            deleteProduct
                ? Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            deleteProduct = false;
                          });
                        },
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        child: Text(
                          'Delete',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          _confirmDelete(context);
                        },
                      )
                    ],
                  )
                : editProduct
                    ? IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            editProduct = false;
                            deleteProduct = false;
                          });
                        })
                    : IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            editProduct = true;
                            deleteProduct = false;
                          });
                        }),
            deleteProduct
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        deleteProduct = false;
                      });
                    })
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        deleteProduct = true;
                        editProduct = false;
                      });
                    })
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                ),
                child: TextField(
                    onChanged: (val) {
                      if (val.length > 0) {
                        setState(() {
                          searchFilter(val);
                        });
                      } else if (val.length <= 0) {
                        setState(() {
                          _search = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.black,
                        iconSize: 20.0,
                        onPressed: () {},
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(25, 8, 0, 5),
                      hintText: 'Search Stockfare',
                    )),
              ),
            ),
          )),
      body: _search
          ? ListView.builder(
              itemCount: _productName.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: ListTile(
                            title: Text(
                              _productName[index].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _productQuantity[index].toString() + ' Units',
                                  style: TextStyle(fontFamily: 'FireSans'),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  _packQuantity[index].toString() + ' Packs',
                                  style: TextStyle(fontFamily: 'FireSans'),
                                )
                              ],
                            ),
                            trailing: Container(
                                child: (() {
                              if (editProduct) {
                                return GestureDetector(
                                  child: Icon(Icons.edit),
                                  onTap: () {
                                    _addToCart.setProductIndexes(index);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProductPage(
                                                  index: index,
                                                  productId: _productId[index],
                                                )));
                                  },
                                );
                              } else if (deleteProduct) {
                                return GestureDetector(
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: CheckboxListTile(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: checkBox[index],
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkBox[index] = newValue;
                                          deleteItem.contains(_productId[index])
                                              ? deleteItem
                                                  .remove(_productId[index])
                                              : deleteItem.add(
                                                  _productId[index].toString());
                                        });
                                      },
                                    ),
                                  ),
                                  onTap: () {
                                    print(_productId[index]);
                                  },
                                );
                              }

                              return Text(_productPrice[index].toString());
                            }())))));
              })
          : StreamBuilder(
              stream: firebaseDb.onValue,
              builder: (context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  _productName.clear();
                  _productQuantity.clear();
                  _packQuantity.clear();
                  _productId.clear();

                  if (snapshot.data.snapshot
                              .value['${_signupNotifier.firebaseId}']
                          ['${_addToCart.fireId}']['product_count'] !=
                      0) {
                    DataSnapshot dataValues = snapshot.data.snapshot;
                    Map values =
                        dataValues.value['${_signupNotifier.firebaseId}']
                            ['${_addToCart.fireId}'];
                    print(values['products']?.map((value) {
                      _productName.add(value['name']);
                      _productQuantity.add(value['product_unit']['quantity']);
                      _packQuantity.add(value['product_pack']['quantity']);
                      _productPrice.add(value['product_unit']['price']);
                      _productId.add(value['id']);
                      checkBox.add(false);
                    }));

                    return ListView.builder(
                        itemCount: _productName.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  child: ListTile(
                                      title: Text(
                                        _productName[index].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _productQuantity[index].toString() +
                                                ' Units',
                                            style: TextStyle(
                                                fontFamily: 'FireSans'),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            _packQuantity[index].toString() +
                                                ' Packs',
                                            style: TextStyle(
                                                fontFamily: 'FireSans'),
                                          )
                                        ],
                                      ),
                                      trailing: Container(
                                          child: (() {
                                        if (editProduct) {
                                          return GestureDetector(
                                            child: Icon(Icons.edit),
                                            onTap: () {
                                              _addToCart
                                                  .setProductIndexes(index);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProductPage(
                                                            index: index,
                                                            productId:
                                                                _productId[
                                                                    index],
                                                          )));
                                            },
                                          );
                                        } else if (deleteProduct) {
                                          return GestureDetector(
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              child: CheckboxListTile(
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                value: checkBox[index],
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    checkBox[index] = newValue;
                                                    deleteItem.contains(
                                                            _productId[index])
                                                        ? deleteItem.remove(
                                                            _productId[index])
                                                        : deleteItem.add(
                                                            _productId[index]
                                                                .toString());
                                                  });
                                                },
                                              ),
                                            ),
                                            onTap: () {
                                              print(_productId[index]);
                                            },
                                          );
                                        }

                                        return Text(
                                            _productPrice[index].toString());
                                      }())))));
                        });
                  } else {
                    return Center(
                      child: Text(
                          'You don\'t have any products yet! \nClick on the button below to add.',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    );
                  }
                }
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                    ]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        focusColor: Theme.of(context).canvasColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductPage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Future<void> _confirmDelete(context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Confirm Delete',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Are you sure you want to delete ${deleteItem.length} Item(s)?',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          )),
          actions: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                    child: Center(
                        child: Text(
                      'No',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                    )),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    child: Center(
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      DialogBoxes().loading(context);
                      _productServices.deleteProducts(deleteItem).then((value) {
                        if (value == 200) {
                          Navigator.pop(_scaffoldKey.currentContext);
                          DialogBoxes().success(_scaffoldKey.currentContext);
                        } else {
                          setState(() {
                            _error = 'You do not have permission to delete';
                            _displaySnackBar(_scaffoldKey.currentContext);
                          });
                          Navigator.pop(_scaffoldKey.currentContext);
                        }
                      });
                    }),
              ],
            )
          ],
        );
      },
    );
  }

  void searchFilter(value) {
    String capitalized = StringUtils.capitalize(value);
    int _index =
        _productName.indexWhere((element) => element.startsWith(capitalized));
    if (_index != -1) {
      print('Contains value');

      String item = _productName[_index];
      setState(() {
        _productName.removeWhere((element) => element != item);
        _productPrice.removeRange(0, _index);
        _packQuantity.removeRange(0, _index);
        _productQuantity.removeRange(0, _index);

        _search = true;
        print(_productName);
      });
    } else {
      print('does not contain value');
    }
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          _error,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
