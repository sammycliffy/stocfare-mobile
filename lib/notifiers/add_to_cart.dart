import 'package:flutter/foundation.dart';

class AddProductToCart with ChangeNotifier {
  int _product = 0;
  int _price = 0;
  int _discount = 0;
  String _productName;
  int _productUnitPrice = 0;
  int _productPackPrice = 0;
  int _productQuantity = 0;
  List _items = [];
  List _type = [];

  int get product => _product;
  int get price => _price;
  int get discount => _price;
  int get productUnitPrice => _productUnitPrice;
  String get productName => _productName;
  int get productQuantity => _productQuantity;
  int get productPackPrice => _productPackPrice;
  List get items => _items;
  List get type => _type;

  void setProductValue(int value) {
    _product = value;
    notifyListeners();
  }

  void setPrice(int value) {
    _price = value;
    notifyListeners();
  }

  void setDiscount(int value) {
    _discount = value;
    notifyListeners();
  }

  void increment() {
    _product++;
    notifyListeners();
  }

  void addToCart(String productName, int productUnitPrice, int productPackPrice,
      List items) {
    _productName = productName;
    _productUnitPrice = productUnitPrice;
    _productPackPrice = productPackPrice;
    _items = items;
    notifyListeners();
  }

  void addItems(List items, List type) {
    _items = items;
    _type = type;
    notifyListeners();
  }
}
