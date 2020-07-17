import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/models/sales_model.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/products_list.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/loader.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Future<ProductList> _productList;
  ProductServices _productServices = ProductServices();
  List _categories = [];
  List _productCount = [];

  @override
  void initState() {
    super.initState();
    _productList = _productServices.getAllProducts();
    _productList.then((value) {
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
        drawer: DrawerPage(),
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Category List')),
        body: FutureBuilder(
          future: _productList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: _categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                _categories[index].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                              Text(
                                _productCount[index].toString() + ' items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor),
                                  child: Center(
                                      child: Text(
                                    'View',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ))),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllProductsList()));
                        },
                      ),
                    );
                  });
            }
            return Loading();
          },
        ));
  }
}
