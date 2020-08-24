import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/color_models.dart';
import 'package:stockfare_mobile/models/products.dart';

class ProductServices {
  //Add products and category
  Future<dynamic> productAddition(
      String productCategory,
      String unitproductName,
      int unitproductPrice,
      int unitproductQuantity,
      int unitLimit,
      int packProductPrice,
      int packQuantity,
      int packLimit,
      String barcode,
      String productDescription,
      String image,
      int productDiscount,
      int productWeight,
      List<ColorDataModel> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    ColorsData colorsData = ColorsData(colorDataModel: data);

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
            "product_colour":
                colorsData.colorDataModel.map((i) => i.toJson()).toList(),
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
            "weight": productWeight,
            "discount": productDiscount,
          }
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      return response.statusCode;
    } else if (json.decode(response.body)['detail'] ==
        "Given token not valid for any token type") {
      String _response = json.decode(response.body)['detail'];
      print(_response);
      print('invalid token');
      return false;
    } else {
      print(response.body);
      return response.body;
    }
  }

  //Add products alone
  Future<dynamic> addProductToCategory(
    String unitproductName,
    int unitproductPrice,
    int unitproductQuantity,
    int unitLimit,
    int packProductPrice,
    int packQuantity,
    int packLimit,
    String barcode,
    String productDescription,
    String image,
    int productDiscount,
    int productWeight,
    List<ColorDataModel> data,
    String categoryId,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    ColorsData colorsData = ColorsData(colorDataModel: data);
    print('THIS IS UNIT PRODUCT' + categoryId);
    final String url =
        'https://stockfare-io.herokuapp.com/api/v1/inventory/create-product/$categoryId/';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "product_colour":
              colorsData.colorDataModel.map((i) => i.toJson()).toList(),
          "product_unit": {
            "price": unitproductPrice,
            "quantity": unitproductQuantity,
            "limit": unitLimit
          },
          "product_pack": {
            "price": packProductPrice,
            "limit": packLimit,
            "quantity": packQuantity,
          },
          "name": unitproductName,
          "image": image,
          "description": productDescription,
          "weight": productWeight,
          "bar_code": barcode,
          "discount": productDiscount
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.statusCode;
    } else {
      return response.body;
    }
  }

  //get products from firebase
  Future<String> getFirebaseId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String firebaseId = sharedPreferences.getString("firebaseId");

    final dbRef = FirebaseDatabase.instance;
    dbRef.setPersistenceEnabled(true);
    dbRef.setPersistenceCacheSizeBytes(10000000);
    final databaseInstance = dbRef.reference();
    databaseInstance.keepSynced(true);
    List allProducts = [];
    return databaseInstance
        .child('inventories')
        .orderByKey()
        .equalTo(firebaseId)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value['$firebaseId'];
      print(values.toString());
      values.forEach((k, v) {
        print(v["name"]);
        print(v['products'].map((value) {
          print(value['name']);
        }));
      });
    });
  }

  //update category
  Future<dynamic> updateCategory(String categoryId, String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    print(name);
    print(categoryId);

    String url =
        'https://stockfare-io.herokuapp.com/api/v1/inventory/update-category/$categoryId/';

    final response = await http.patch(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "name": name,
        }));
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      print(response.body);
    }
  }

  Future<dynamic> deleteCategory(List<String> deleteItem) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    print(deleteItem);
    String url =
        'https://stockfare-io.herokuapp.com/api/v1/inventory/delete-category/';
    final request = http.Request("DELETE", Uri.parse(url));
    request.headers.addAll(<String, String>{
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    });
    request.body = jsonEncode(<String, dynamic>{'items': deleteItem});
    final response = await request.send();
    if (response.statusCode != 200)
      // return Future.error("error: status code ${response.statusCode}");
      print(response.reasonPhrase);

    // return await response.stream.bytesToString();
    return response.statusCode;
  }

  Future<dynamic> productFileUpload(String categoryId, File file) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String firebaseId = sharedPreferences.getString("firebaseId");
    print(file);
    String token = sharedPreferences.getString('token');
    print(firebaseId);
    print(categoryId.toString() + 'this is category');
    String url =
        'http://stockfare-io.herokuapp.com/api/v2/inventory/upload_file/$categoryId/$firebaseId/';
    print(url);
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll(<String, String>{
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var data = await http.MultipartFile.fromPath("files", file.path);
    request.files.add(data);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var responseCode = response.statusCode;
    print(responseString);
    if (response.statusCode != 200 || response.statusCode != 201) {
      return responseString;
    }
    print(response.statusCode);
    return response.statusCode;
  }

  Future<dynamic> deleteProducts(List<String> deleteItem) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String url =
        'https://stockfare-io.herokuapp.com/api/v1/inventory/category/product/delete/';
    final request = http.Request("DELETE", Uri.parse(url));
    request.headers.addAll(<String, String>{
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    });
    request.body = jsonEncode(<String, dynamic>{'items': deleteItem});
    final response = await request.send();
    if (response.statusCode != 200)
      return Future.error("error: status code ${response.statusCode}");
    // return await response.stream.bytesToString();

    return response.statusCode;
  }

  Future<ProductList> getAllProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    print(branchId);
    String token = sharedPreferences.getString('token');
    print(token);
    final String url =
        'http://stockfare-io.herokuapp.com/api/v1/inventory/category/$branchId/';
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
      print('error');
    }
  }

  Future<bool> check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
