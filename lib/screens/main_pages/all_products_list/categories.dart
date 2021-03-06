import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/product_list.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/dashboard/main_dashboard.dart';

import 'package:stockfare_mobile/services/product_services.dart';

import 'add_single_products/form.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Future<ProductList> _productList;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProductServices _productServices = ProductServices();
  List _categoryId = [];
  List _categories = [];
  List _productCount = [];
  List _categoryIdSearch = [];
  List _categoriesSearch = [];
  List _productCountSearch = [];
  bool editCategory = false;
  bool deleteCategory = false;
  String updatedCategory;
  List _firebaseKeys = [];
  List _firebaseKeysSearch = [];
  List<String> deleteItem = [];
  List<bool> checkBox = [];
  bool _search = false;
  bool loading = false;
  String _error;
  List _lowStockId = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _productList = _productServices.getAllProducts();
    // _productList.then((value) {
    //   print(value?.results?.map((category) {
    //     _categoryId.add(category.id);
    //     checkBox.add(false);
    //     setState(() {
    //       _categories.add(category.name);
    //       _productCount.add(category.productCount);
    //     });
    //   }));
    // });
  }

  goback(context) {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProductNotifier =
        Provider.of<AddProductNotifier>(context);
    AddProductToCart _addToCart = Provider.of<AddProductToCart>(context);
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    final firebaseDb =
        _productServices.getFirebaseData(_signupNotifier.firebaseId);
    final _firebaseNotification = _productServices
        .getFirebaseNotification(_signupNotifier.notificationId);
    return WillPopScope(
      onWillPop: () {
        return goback(context);
      },
      child: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
              Colors.red[100],
              Colors.white,
            ],
                stops: [
              0.0,
              1.0
            ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                tileMode: TileMode.repeated)),
        child: WillPopScope(
          onWillPop: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => DashBoard())),
          child: Scaffold(
            key: _scaffoldKey,
            drawer: DrawerPage(),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                title: Text('Category List'),
                actions: <Widget>[
                  deleteCategory
                      ? Row(
                          children: <Widget>[
                            GestureDetector(
                              child: Text(
                                'Cancel',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                setState(() {
                                  deleteCategory = false;
                                });
                              },
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                                child: Container(
                                  child: Text(
                                    'Delete',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onTap: () {
                                  _confirmDelete(context);
                                })
                          ],
                        )
                      : editCategory
                          ? GestureDetector(
                              child: Container(
                                  height: 50,
                                  child: Center(
                                      child: Text('Cancel',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)))),
                              onTap: () {
                                setState(() {
                                  editCategory = false;
                                  deleteCategory = false;
                                });
                              })
                          : GestureDetector(
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  editCategory = true;
                                  deleteCategory = false;
                                });
                              }),
                  deleteCategory
                      ? IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              deleteCategory = false;
                            });
                          })
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              deleteCategory = true;
                              editCategory = false;
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
                      child: TextFormField(
                          onChanged: (val) {
                            if (val.length > 0) {
                              setState(() {
                                search(val);
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
                ? Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    child: ListView.builder(
                        itemCount: _categoriesSearch.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 3,
                                    child: ListTile(
                                        title: Text(
                                          _categoriesSearch[index].toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        subtitle: Text(
                                          _productCountSearch[index]
                                                  .toString() +
                                              ' items',
                                        ),
                                        trailing: Container(
                                            child: (() {
                                          if (editCategory) {
                                            return GestureDetector(
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onTap: () {
                                                _updateDialog(
                                                    _categoriesSearch[index]
                                                        .toString(),
                                                    _categoryIdSearch[index]);
                                              },
                                            );
                                          } else if (deleteCategory) {
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
                                                      checkBox[index] =
                                                          newValue;
                                                      deleteItem.contains(
                                                              _categoryId[
                                                                  index])
                                                          ? deleteItem.remove(
                                                              _categoryId[
                                                                  index])
                                                          : deleteItem.add(
                                                              _categoryId[index]
                                                                  .toString());
                                                    });
                                                  },
                                                ),
                                              ),
                                              onTap: () {
                                                print(_categoryId[index]);
                                              },
                                            );
                                          }

                                          return Image.asset(
                                              'assets/images/category.png');
                                        }()))))),
                            onTap: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.remove('id');

                              _addToCart.addID(_categoryIdSearch[index],
                                  _categoriesSearch[index]);
                              _addToCart.setFireId(_firebaseKeysSearch[index]);
                              _addProductNotifier
                                  .setCategoryId(_categoryIdSearch[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductListPage()));
                            },
                          );
                        }),
                  )
                : StreamBuilder(
                    stream: firebaseDb,
                    builder: (context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.snapshot.value != null) {
                          _categories.clear();
                          _categoryId.clear();
                          _productCount.clear();

                          DataSnapshot dataValues = snapshot.data.snapshot;
                          var data =
                              dataValues.value['${_signupNotifier.firebaseId}'];
                          if (data is String) {
                            print('yes');
                          } else {
                            Map<dynamic, dynamic> values = dataValues
                                .value['${_signupNotifier.firebaseId}'];

                            values?.forEach((key, values) {
                              _firebaseKeys.add(key);

                              _categories.add(values['name']);
                              _categoryId.add(values['id']);
                              _productCount.add(values['product_count']);
                              checkBox.add(false);
                            });

                            return StreamBuilder(
                                stream: _firebaseNotification,
                                builder:
                                    (context, AsyncSnapshot<Event> snapshot1) {
                                  if (snapshot1.hasData) {
                                    _lowStockId.clear();
                                    if (snapshot1.data.snapshot.value != null) {
                                      DataSnapshot dataValues =
                                          snapshot1.data.snapshot;
                                      var data = dataValues.value[
                                          '${_signupNotifier.notificationId}'];
                                      if (data is String) {
                                        print('yes');
                                      } else {
                                        Map<dynamic,
                                            dynamic> values = dataValues
                                                .value[
                                            '${_signupNotifier.notificationId}'];

                                        values?.forEach((key, values) {
                                          print(values);
                                          Map<dynamic, dynamic> value = values;
                                          value?.forEach((key, data) {
                                            Map<dynamic, dynamic> newData =
                                                data;
                                            newData?.forEach((key, data) {
                                              print(data);
                                              _lowStockId.add(data['name']);
                                            });
                                          });
                                        });
                                      }

                                      return Column(
                                        children: [
                                          SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 280),
                                            child: Container(
                                              width: 55,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue[700],
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                child: Text(
                                                    _categories.length
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Scrollbar(
                                              isAlwaysShown: true,
                                              controller: _scrollController,
                                              child: ListView.builder(
                                                  itemCount: _categories.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    print(_lowStockId);
                                                    return GestureDetector(
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Card(
                                                              semanticContainer:
                                                                  true,
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              elevation: 3,
                                                              child: ListTile(
                                                                  title: Row(
                                                                    children: [
                                                                      Text(
                                                                        _categories[index]
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              18,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      // (() {
                                                                      //   if (_categories[
                                                                      //           index] ==
                                                                      //       _lowStockId[
                                                                      //           index]) {
                                                                      //     return Container(
                                                                      //         width:
                                                                      //             40,
                                                                      //         height:
                                                                      //             25,
                                                                      //         decoration: BoxDecoration(
                                                                      //             color: Colors.orange,
                                                                      //             borderRadius: BorderRadius.circular(5)),
                                                                      //         child: Center(child: Text('Low', style: TextStyle(color: Colors.white))));
                                                                      //   } else {
                                                                      //     return SizedBox();
                                                                      //   }
                                                                      // }())
                                                                    ],
                                                                  ),
                                                                  subtitle:
                                                                      Text(
                                                                    _productCount[index]
                                                                            .toString() +
                                                                        ' items',
                                                                  ),
                                                                  trailing:
                                                                      Container(
                                                                          child:
                                                                              (() {
                                                                    if (editCategory) {
                                                                      return GestureDetector(
                                                                        child:
                                                                            Text(
                                                                          'Edit',
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          _updateDialog(
                                                                              _categories[index].toString(),
                                                                              _categoryId[index]);
                                                                        },
                                                                      );
                                                                    } else if (deleteCategory) {
                                                                      return GestureDetector(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100,
                                                                          height:
                                                                              100,
                                                                          child:
                                                                              CheckboxListTile(
                                                                            activeColor:
                                                                                Theme.of(context).primaryColor,
                                                                            value:
                                                                                checkBox[index],
                                                                            onChanged:
                                                                                (newValue) {
                                                                              setState(() {
                                                                                checkBox[index] = newValue;
                                                                                deleteItem.contains(_categoryId[index]) ? deleteItem.remove(_categoryId[index]) : deleteItem.add(_categoryId[index].toString());
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              _categoryId[index]);
                                                                        },
                                                                      );
                                                                    }
                                                                    return Image
                                                                        .asset(
                                                                            'assets/images/category.png');
                                                                  }()))))),
                                                      onTap: () async {
                                                        SharedPreferences
                                                            sharedPreferences =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        sharedPreferences
                                                            .remove('id');
                                                        _addToCart.addID(
                                                            _categoryId[index],
                                                            _categories[index]);
                                                        _addToCart.setFireId(
                                                            _firebaseKeys[
                                                                index]);
                                                        _addProductNotifier
                                                            .setCategoryId(
                                                                _categoryId[
                                                                    index]);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ProductListPage()));
                                                      },
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }
                                  return Column(
                                      children: [CircularProgressIndicator()]);
                                });
                          }
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Center(child: Text('Add product.')),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: GestureDetector(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Icon(Icons.add,
                                          size: 50, color: Colors.white)),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FormPage()));
                                },
                              ),
                            )
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
            floatingActionButton: FloatingActionButton(
              focusColor: Theme.of(context).canvasColor,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormPage()));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue[700],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateDialog(category, id) async {
    return showDialog<void>(
      context: _scaffoldKey.currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'UPDATE CATEGORY',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (val) => setState(() {
                  updatedCategory = val;
                }),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  hintText: category,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )),
          actions: <Widget>[
            GestureDetector(
                child: Center(
                  child: Container(
                    height: 40,
                    width: 260,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      'update',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  DialogBoxes().loading(context);

                  _productServices
                      .updateCategory(id, updatedCategory)
                      .then((value) {
                    if (value == 200) {
                      Navigator.pop(_scaffoldKey.currentContext);
                      DialogBoxes().success(_scaffoldKey.currentContext);
                    } else {
                      Navigator.pop(_scaffoldKey.currentContext);
                      setState(() {
                        _error = 'You do not have permission to update';
                        _displaySnackBar(_scaffoldKey.currentContext);
                      });
                    }
                  });
                }),
          ],
        );
      },
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
                      _productServices.deleteCategory(deleteItem).then((value) {
                        if (value == 200) {
                          Navigator.pop(_scaffoldKey.currentContext);
                          DialogBoxes().success(_scaffoldKey.currentContext);
                        } else {
                          Navigator.pop(_scaffoldKey.currentContext);
                          setState(() {
                            _error = 'You do not have permission to delete';
                            _displaySnackBar(_scaffoldKey.currentContext);
                          });
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

  void search(value) {
    String capitalized = StringUtils.capitalize(value);
    _categoriesSearch.clear();
    _productCountSearch.clear();
    _categoryIdSearch.clear();
    _firebaseKeysSearch.clear();
    setState(() {
      print(_categories);
      _search = true;
      print(_categories.map((value) {
        if (value.contains(capitalized)) {
          _categoriesSearch.add(value);
          _productCountSearch.add(_productCount[_categories.indexOf(value)]);
          _categoryIdSearch.add(_categoryId[_categories.indexOf(value)]);
          _firebaseKeysSearch.add(_firebaseKeys[_categories.indexOf(value)]);
        }
      }));
    });
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
