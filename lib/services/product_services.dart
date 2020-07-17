import 'dart:convert';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/products.dart';

class ProductServices {
  Future<dynamic> productAddition(
    String productCategory,
    String unitproductName,
    int unitproductPrice,
    int unitproductQuantity,
    double unitLimit,
    String packproductName,
    int packProductPrice,
    int packQuantity,
    double packLimit,
    String barcode,
    String productDescription,
    String image,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');

    final String url =
        'https://stockfare-io.herokuapp.com/api/v1/inventory/create-category/$branchId/';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "name": productCategory,
          "product": {
            "product_unit": {
              "price": unitproductPrice,
              "quantity": unitproductQuantity,
              "limit": unitLimit,
            },
            "product_pack": {
              "price": packProductPrice,
              "limit": unitLimit,
              "quantity": packQuantity,
            },
            "image": image,
            "name": unitproductName,
            "barcode": barcode,
            "description": productDescription,
          }
        }));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      sharedPreferences.setString("token", responseJson['token']['access']);
      return response.statusCode;
    } else if (response.statusCode == 400) {
      print(response.statusCode);
      print(response.body);
      return response.statusCode;
    }
    return response.statusCode;
  }

  Future<dynamic> allProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String firebaseId = sharedPreferences.getString("firebaseId");
    final dbRef = FirebaseDatabase.instance.reference();
    return dbRef
        .child('inventories')
        .orderByKey()
        .equalTo(firebaseId)
        .once()
        .then((DataSnapshot snapshot) {
      dynamic product = ProductList.fromJson(snapshot.value);
    });
  }

  Future<ProductList> getAllProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    print(token);
    final String url =
        'http://stockfare-io.herokuapp.com/api/v1/inventory/category/8e044e8c-263b-40f7-afb7-601154b59601/';
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return ProductList.fromJson(json.decode(response.body));

      // //display product name
      // print(products.results.map((title) {
      //   return title.name;
      // }));

      // //display product name
      // print(products.results.map((title) {
      //   return title.products[0].name;
      // }));

      // //product price
      // print(products.results.map((title) {
      //   return title.products[0].productUnit.price;
      // }));

      // //product quantity
      // print(products.results.map((title) {
      //   return title.products[0].productUnit.quantity;
      // }));

      // //product limit
      // print(products.results.map((title) {
      //   return title.products[0].productUnit.limit;
      // }));

      // //display images
      // print(products.results.map((title) {
      //   return title.products[0].productImage.map((title) {
      //     return title.imageLink;
      //   });
      // }));

      // //packPrice
      // print(products.results.map((title) {
      //   return title.products[0].productPack.price;
      // }));

      // //packlimit
      // print(products.results.map((title) {
      //   return title.products[0].productPack.limit;
      // }));
      // return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
