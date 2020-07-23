import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/products.dart';
import 'package:stockfare_mobile/screens/intro_pages/addProducts.dart';

import 'package:stockfare_mobile/services/product_services.dart';

class ProductListPage extends StatefulWidget {
  final int customerIndex;
  ProductListPage({Key key, @required this.customerIndex}) : super(key: key);
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<ProductList> _productList;
  ProductServices _productServices = ProductServices();
  List _categories = [];
  List _productCount = [];
  List _productName = [];
  List _productPrice = [];
  List _productImage = [];
  List _productQuantity = [];
  List _productPack = [];

  @override
  void initState() {
    super.initState();
    _productList = _productServices.getAllProducts();
    _productList.then((value) {
      print(value.results[widget.customerIndex].products.map((name) {
        _productName.add(name.name);
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
    print(_productName);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(_categories[widget.customerIndex] == 0
              ? 'Category'
              : _categories[widget.customerIndex]),
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
                              trailing:
                                  Text(_productPrice[index].toString()))));
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
