import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/screens/intro_pages/addProducts.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/products_list.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';

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
      appBar: AppBar(
          title: Text('Category List'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: null),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: null)
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
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          child: ListTile(
                        leading: FlutterLogo(size: 56.0),
                        title: Text(
                          _categories[index].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          _productCount[index].toString() + ' items',
                        ),
                        trailing: Icon(Icons.more_vert),
                      )));
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
                  child: Text('Your sales summary will display here',
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
}
