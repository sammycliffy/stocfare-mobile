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
  List _items = [];
  List _countItem;
  String _productId;

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

  String get productId => _productId;

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

  void addToCart(String productId, String productName, int productUnitPrice,
      int productPackPrice, List items) {
    _productId = productId;
    _productName = productName;
    _productUnitPrice = productUnitPrice;
    _productPackPrice = productPackPrice;
    _items = items;
    notifyListeners();
  }

  void addItems(
    List items,
    List countItem,
  ) {
    _items = items;
    _countItem = countItem;
    notifyListeners();
  }

  void addQuantity(int quantity) {
    _quantity = quantity;
    notifyListeners();
  }

  void addProduct(int product) {
    _product = product;
    notifyListeners();
  }

  void addPrice(int price) {
    _prices = price;
    notifyListeners();
  }
}
