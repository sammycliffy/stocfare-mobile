import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
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
  String _categoryId;
  List _categories = [];
  List _productCount = [];
  List _productName = [];
  List _productPrice = [];
  List _productImage = [];
  List _productQuantity = [];
  List _productId = [];
  List _productPack = [];
  bool editProduct = false;
  bool deleteProduct = false;
  List<bool> checkBox = [];
  List<String> deleteItem = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addProductNotifier =
          Provider.of<AddProductNotifier>(context, listen: false);
    });
    _productList = _productServices.getAllProducts();
    _productList.then((value) {
      _categoryId = value.results[_addProductNotifier.categoryIndex].id;
      print(
          value.results[_addProductNotifier.categoryIndex].products.map((name) {
        _productName.add(name.name);
        checkBox.add(false);
        _productId.add(name.id);
        _productPrice.add(name.productUnit.price);
        _productImage.add(name.productImage[0].imageLink);
        _productQuantity.add(name.productUnit.quantity);

        _productPack.add(name.productPack.quantity);
        return name.name;
      }));

      print(value.results.map((category) {
        setState(() {
          _categories.add(category.name);
          _productCount.add(category.productCount);
        });
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: FutureBuilder(
              future: _productList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _addProductNotifier.setCategoryId(_categoryId);
                  return Text(_categories[_addProductNotifier.categoryIndex]
                      .toString());
                }
                return Text('Category Name');
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
                          DialogBoxes().loading(context);
                          _productServices
                              .deleteProducts(deleteItem)
                              .then((value) {
                            if (value == 200) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => super.widget));
                            }
                          });
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
            if (_productName.length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text('No Data',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Center(
                    child: Text(
                        'You don\'t have any products yet! \nClick on the button below to add.',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  )
                ],
              );
            }
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _productQuantity[index].toString() +
                                        ' Units',
                                    style: TextStyle(fontFamily: 'FireSans'),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    _productPack[index].toString() + ' Packs',
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
                                      _addProductNotifier
                                          .setProductIndex(index);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProductPage()));
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
                                            deleteItem
                                                    .contains(_productId[index])
                                                ? deleteItem
                                                    .remove(_productId[index])
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

                                return Text(_productPrice[index].toString());
                              }())))));
                });
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
}

// Text(_productPrice[index].toString())
