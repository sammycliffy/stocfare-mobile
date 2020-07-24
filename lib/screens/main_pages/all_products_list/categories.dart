import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/intro_pages/addProducts.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/product_list.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';

import 'package:stockfare_mobile/services/product_services.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Future<ProductList> _productList;
  ProductServices _productServices = ProductServices();
  List _categoryId = [];
  List _categories = [];
  List _productCount = [];
  bool editCategory = false;
  bool deleteCategory = false;
  String updatedCategory;
  List deleteItem = [];
  List<bool> checkBox = [];
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
      drawer: DrawerPage(),
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text('Category List'),
          actions: <Widget>[
            deleteCategory
                ? Row(
                    children: <Widget>[
                      InkWell(
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          setState(() {
                            deleteCategory = false;
                          });
                        },
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  )
                : Row(
                    children: <Widget>[
                      IconButton(
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
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              deleteCategory = true;
                              editCategory = false;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
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
      body: FutureBuilder(
        future: _productList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: ListTile(
                                title: Text(
                                  _categories[index].toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  _productCount[index].toString() + ' items',
                                ),
                                trailing: Container(
                                    child: (() {
                                  if (editCategory) {
                                    return GestureDetector(
                                      child: Icon(Icons.edit),
                                      onTap: () {
                                        _updateDialog(
                                            context,
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
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          value: checkBox[index],
                                          onChanged: (newValue) {
                                            setState(() {
                                              checkBox[index] = newValue;
                                              deleteItem.contains(
                                                      _categoryId[index])
                                                  ? deleteItem.remove(
                                                      _categoryId[index])
                                                  : deleteItem
                                                      .add(_categoryId[index]);
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
                      _addProductNotifier.setProductIndex(index);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductListPage()));
                    },
                  );
                });
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.shopping_basket,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Center(
                  child: Text('Your Products will appear here',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                ),
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

  Future<void> _updateDialog(context, category, id) async {
    return showDialog<void>(
      context: context,
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
                  print(updatedCategory);
                  print(id);
                  Navigator.pop(context);
                  _productServices.updateCategory(id, updatedCategory);
                }),
          ],
        );
      },
    );
  }
}
