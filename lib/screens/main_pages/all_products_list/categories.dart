import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/product_list.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';

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
  List<String> deleteItem = [];
  List<bool> checkBox = [];
  bool _search = false;
  bool loading = false;
  String _error;

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

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProductNotifier =
        Provider.of<AddProductNotifier>(context);
    AddProductToCart _addToCart = Provider.of<AddProductToCart>(context);
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
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationPage())),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerPage(),
        backgroundColor: Colors.white,
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
                            child: Text(
                              'Delete',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              _confirmDelete(context);
                            })
                      ],
                    )
                  : editCategory
                      ? IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              editCategory = false;
                              deleteCategory = false;
                            });
                          })
                      : IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
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
                        hintText: 'Search stockfare_mobile',
                      )),
                ),
              ),
            )),
        body: _search
            ? ListView.builder(
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  _productCountSearch[index].toString() +
                                      ' items',
                                ),
                                trailing: Container(
                                    child: (() {
                                  if (editCategory) {
                                    return GestureDetector(
                                      child: Icon(Icons.edit),
                                      onTap: () {
                                        _updateDialog(
                                            _categoriesSearch[index].toString(),
                                            _categoryIdSearch[index]);
                                      },
                                    );
                                  } else if (deleteCategory) {
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
                                              deleteItem.contains(
                                                      _categoryIdSearch[index])
                                                  ? deleteItem.remove(
                                                      _categoryIdSearch[index])
                                                  : deleteItem.add(
                                                      _categoryIdSearch[index]
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

                                  return Icon(Icons.more_vert);
                                }()))))),
                    onTap: () {
                      _addProductNotifier.setCategoryIndex(index);
                      _addToCart.setFireId(_firebaseKeys[index]);
                      _addProductNotifier
                          .setCategoryId(_categoryIdSearch[index]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductListPage()));
                    },
                  );
                })
            : StreamBuilder(
                stream: firebaseDb.onValue,
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
                        Map<dynamic, dynamic> values =
                            dataValues.value['${_signupNotifier.firebaseId}'];

                        values?.forEach((key, values) {
                          _firebaseKeys.add(key);
                          _categories.add(values['name']);
                          _categoryId.add(values['id']);
                          _productCount.add(values['product_count']);
                          checkBox.add(false);
                        });

                        return ListView.builder(
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        elevation: 3,
                                        child: ListTile(
                                            title: Text(
                                              _categories[index].toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              _productCount[index].toString() +
                                                  ' items',
                                            ),
                                            trailing: Container(
                                                child: (() {
                                              if (editCategory) {
                                                return GestureDetector(
                                                  child: Icon(Icons.edit),
                                                  onTap: () {
                                                    _updateDialog(
                                                        _categories[index]
                                                            .toString(),
                                                        _categoryId[index]);
                                                  },
                                                );
                                              } else if (deleteCategory) {
                                                return GestureDetector(
                                                  child: Container(
                                                    width: 100,
                                                    height: 100,
                                                    child: CheckboxListTile(
                                                      activeColor:
                                                          Theme.of(context)
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
                                                                  _categoryId[
                                                                          index]
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

                                              return Icon(Icons.more_vert);
                                            }()))))),
                                onTap: () {
                                  _addToCart.addID(
                                      _categoryId[index], _categories[index]);
                                  _addToCart.setFireId(_firebaseKeys[index]);
                                  _addProductNotifier
                                      .setCategoryId(_categoryId[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductListPage()));
                                },
                              );
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FormPage()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
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
    setState(() {
      print(_categories);
      _search = true;
      print(_categories.map((value) {
        if (value.contains(capitalized)) {
          _categoriesSearch.add(value);
          _productCountSearch.add(_productCount[_categories.indexOf(value)]);
          _categoryIdSearch.add(_categoryId[_categories.indexOf(value)]);
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
