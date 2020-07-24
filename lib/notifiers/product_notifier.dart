import 'package:flutter/foundation.dart';

class AddProductNotifier with ChangeNotifier {
  String _unitproductName;
  String _productCategory;
  String _productDescription;
  double _unitLimit = 0;
  int _unitproductPrice = 0;
  int _unitproductQuantity = 0;
  int _productBarcode = 0;
  String _packProductName;
  int _packProductPrice = 0;
  double _packLimit = 0;
  int _packQuantity = 0;

  //this is used to transfer the product index to the next page
  int _productIndex = 0;

  String get unitproductName => _unitproductName;
  String get packProductName => _packProductName;
  double get packLimit => _packLimit;
  int get packQuantity => _packQuantity;
  int get packProductPrice => _packProductPrice;
  String get productDescription => _productDescription;
  String get productCategory => _productCategory;
  int get unitproductPrice => _unitproductPrice;
  int get unitproductQuantity => _unitproductQuantity;
  double get unitLimit => _unitLimit;
  int get productBarcode => _productBarcode;

  int get productIndex => _productIndex;

  void setFirstProduct(String productCategory, String productName,
      double unitLimit, int productPrice, String productDescription) {
    _productCategory = productCategory;
    _unitproductName = productName;
    _unitproductPrice = productPrice;
    _productDescription = productDescription;
    notifyListeners();
  }

  void setPackProducts(
    String packProductName,
    int packProductPrice,
    double packLimit,
    int packQuantity,
  ) {
    _packProductName = packProductName;
    _packProductPrice = packProductPrice;
    _packLimit = packLimit;
    _packQuantity = packQuantity;
    notifyListeners();
  }

  void setProductIndex(int productIndex) {
    _productIndex = productIndex;
  }
}
