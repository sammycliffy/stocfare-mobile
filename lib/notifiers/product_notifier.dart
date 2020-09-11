import 'package:flutter/foundation.dart';
import 'package:stockfare_mobile/models/color_models.dart';

class AddProductNotifier with ChangeNotifier {
  String _unitproductName;
  String _productCategory;
  String _productDescription;
  int _unitLimit = 0;
  int _unitproductPrice = 0;
  int _unitproductQuantity = 0;
  int _productBarcode = 0;
  int _productDiscount = 0;
  int _productWeight = 0;
  List<ColorDataModel> _data;

  int _packProductPrice = 0;
  int _packLimit = 0;
  int _packQuantity = 0;

  //this is used to transfer the product index to the next page
  int _categoryIndex;
  int _productIndex = 0;

  //set categoryid to be used to add product;
  String _categoryId;
  String _firebaseKey;
  String get unitproductName => _unitproductName;

  int get packLimit => _packLimit;
  int get packQuantity => _packQuantity;
  int get packProductPrice => _packProductPrice;
  String get productDescription => _productDescription;
  String get productCategory => _productCategory;
  int get unitproductPrice => _unitproductPrice;
  int get unitproductQuantity => _unitproductQuantity;
  int get unitLimit => _unitLimit;
  int get productBarcode => _productBarcode;
  int get categoryIndex => _categoryIndex;
  int get productIndex => _productIndex;
  int get productDiscount => _productDiscount;
  int get productWeight => _productWeight;
  String get categoryId => _categoryId;
  String get firebasekey => _firebaseKey;
  List<ColorDataModel> get data => _data;
  void setFirstProduct(
    String productCategory,
    String productName,
    int unitLimit,
    int unitQuantity,
    int productPrice,
    String productDescription,
    int productDiscount,
    int productWeight,
    List<ColorDataModel> data,
  ) {
    _productCategory = productCategory;
    _unitproductName = productName;
    _unitLimit = unitLimit;
    _unitproductQuantity = unitQuantity;
    _unitproductPrice = productPrice;
    _productDescription = productDescription;
    _productDiscount = productDiscount;
    _productWeight = productWeight;
    _data = data;

    notifyListeners();
  }

  void setPackProducts(
    int packProductPrice,
    int packLimit,
    int packQuantity,
  ) {
    _packProductPrice = packProductPrice;
    _packLimit = packLimit;
    _packQuantity = packQuantity;
    notifyListeners();
  }

  void setCategoryIndex(int categoryIndex) {
    _categoryIndex = categoryIndex;
  }

  void setProductIndex(int productIndex) {
    _productIndex = productIndex;
  }

  void setCategoryId(String categoryId) {
    _categoryId = categoryId;
  }

  void setFirebaseKey(String firebaseKey) {
    _firebaseKey = firebaseKey;
  }
}
