import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/product_list.dart';
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
  final PageStorageBucket _bucket = new PageStorageBucket();
  ProductServices _productServices = ProductServices();
  List _categoryId = [];
  List _categories = [];
  List _productCount = [];
  bool editCategory = false;
  bool deleteCategory = false;
  String updatedCategory;
  List<String> deleteItem = [];
  List<bool> checkBox = [];
  bool search = false;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _productList = _productServices.getAllProducts();
    _productList.then((value) {
      print(value.results.map((category) {
        _categoryId.add(category.id);
        checkBox.add(false);
        setState(() {
          _categories.add(category.name);
          _productCount.add(category.productCount);
        });
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProductNotifier =
        Provider.of<AddProductNotifier>(context);
    return Scaffold(
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
                    onTap: () {
                      setState(() {
                        search = true;
                      });
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
      body: search
          ? Center(
              child: Text('Through'),
            )
          : FutureBuilder(
              future: _productList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        if (_categories.length == 0) {
                          return Text(
                              'You do not have any product yet. Click the button below to add');
                        }
                        return GestureDetector(
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
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
                                                  _categories[index].toString(),
                                                  _categoryId[index]);
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
                                                    checkBox[index] = newValue;
                                                    deleteItem.contains(
                                                            _categoryId[index])
                                                        ? deleteItem.remove(
                                                            _categoryId[index])
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

                                        return Icon(Icons.more_vert);
                                      }()))))),
                          onTap: () {
                            _addProductNotifier.setCategoryIndex(index);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductListPage()));
                          },
                        );
                      });
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

                      setState(() {
                        _categoryId.clear();
                        _categories.clear();

                        _productList = _productServices.getAllProducts();
                        _productList.then((value) {
                          print(value.results.map((category) {
                            _categoryId.add(category.id);
                            checkBox.add(false);
                            setState(() {
                              _categories.add(category.name);
                              _productCount.add(category.productCount);
                            });
                          }));
                        });
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

                          setState(() {
                            _categoryId.clear();
                            _categories.clear();

                            _productList = _productServices.getAllProducts();
                            _productList.then((value) {
                              print(value.results.map((category) {
                                _categoryId.add(category.id);
                                checkBox.add(false);
                                setState(() {
                                  _categories.add(category.name);
                                  _productCount.add(category.productCount);
                                });
                              }));
                            });
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
}
