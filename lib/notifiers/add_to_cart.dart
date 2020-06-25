import 'package:flutter/foundation.dart';

class AddProductToCart with ChangeNotifier {
  int _product = 0;
  int _price = 0;
  int _discount = 0;

  int get product => _product;
  int get price => _price;
  int get discount => _price;

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
}
