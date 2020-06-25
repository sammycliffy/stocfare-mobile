import 'package:flutter/foundation.dart';

class AddProductNotifier with ChangeNotifier {
  String _productName;
  String _productCategory;
  int _productPrice = 0;
  int _productQuantity = 0;
  int _productBarcode = 0;

  String get productName => _productName;
  String get productCategory => _productCategory;
  int get productPrice => _productPrice;
  int get productQuantity => _productQuantity;
  int get productBarcode => _productBarcode;

  void setproductName(String value) {
    _productName = value;
    notifyListeners();
  }

  void setproductCategory(String value) {
    _productCategory = value;
    notifyListeners();
  }

  void setproductPrice(int value) {
    _productPrice = value;
    notifyListeners();
  }

  void setproductQuantity(int value) {
    _productQuantity = value;
    notifyListeners();
  }

  void setproductBarcode(int value) {
    _productBarcode = value;
    notifyListeners();
  }
}
