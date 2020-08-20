import 'package:flutter/foundation.dart';

class AddProductToCart with ChangeNotifier {
  int _product = 0;
  int _price = 0;
  int _prices = 0;
  int _discount = 0;
  String _productName;
  int _productUnitPrice = 0;
  int _productPackPrice = 0;
  int _productQuantity = 0;
  int _quantity = 0;
  int _packQuantity = 0;
  List _items = [];
  List _countItem;
  String _productId;
  int _index;
  List _listOfQuantity = [];
  int _packValue = 0;
  int _value = 0;
  bool _clear = false;

  int get product => _product;
  int get price => _price;
  int get discount => _price;
  int get productUnitPrice => _productUnitPrice;
  String get productName => _productName;
  int get productQuantity => _productQuantity;
  int get productPackPrice => _productPackPrice;
  List get items => _items;
  int get quantity => _quantity;
  List get countItem => _countItem;
  int get prices => _prices;
  int get index => _index;
  List get listOfQuantity => _listOfQuantity;
  String get productId => _productId;
  int get packQuantity => _packQuantity;
  int get value => _value;
  int get packValue => _packValue;
  bool get clear => _clear;
  void setProductValue(int value) {
    _product = value;
    notifyListeners();
  }

  void setPrice(int value) {
    _price = value;
    notifyListeners();
  }

  void addPackQuantity(int val) {
    _packQuantity = val;
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

  void addItem(List items) {
    _items = items;
    notifyListeners();
  }

  void addShoppingCartUnit(int value) {
    _value = value;
    notifyListeners();
  }

  void addShoppingCartPack(int value) {
    _packValue = value;
    notifyListeners();
  }

  void setCartClear(bool clear) {
    _clear = clear;
    notifyListeners();
  }
}
