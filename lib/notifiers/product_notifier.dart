import 'package:flutter/foundation.dart';

class AddProductNotifier with ChangeNotifier {
  String _productName;
  String _productCategory;
  String _productDescription;
  int _quantityAlert = 0;
  int _productPrice = 0;
  int _productQuantity = 0;
  int _productBarcode = 0;

  String get productName => _productName;
  String get productDescription => _productDescription;
  String get productCategory => _productCategory;
  int get productPrice => _productPrice;
  int get productQuantity => _productQuantity;
  int get quantityAlert => _quantityAlert;
  int get productBarcode => _productBarcode;

  void setproductName(String value) {
    _productName = value;
    notifyListeners();
  }

  void setFirstProduct(String productCategory, String productName,
      int productPrice, String productDescription) {
    _productCategory = productCategory;
    _productName = productName;
    _productPrice = productPrice;
    _productDescription = productDescription;
    notifyListeners();
  }

  void setQuantity(int productQuantity, int quantityAlert) {
    _productQuantity = productQuantity;
    _quantityAlert = quantityAlert;
    notifyListeners();
  }

  void setAllProduct(
      String productCategory,
      String productName,
      int productPrice,
      String productDescription,
      int productQuantity,
      int quantityAlert) {
    _productCategory = productCategory;
    _productName = productName;
    _productPrice = productPrice;
    _productDescription = productDescription;
    _productQuantity = productQuantity;
    _quantityAlert = quantityAlert;
    notifyListeners();
  }
}
