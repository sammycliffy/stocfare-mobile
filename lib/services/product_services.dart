import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/color_models.dart';
import 'package:stockfare_mobile/models/products.dart';

class ProductServices {
  //Add products and category
  Future<dynamic> productAddition(
      String productCategory,
      String unitproductName,
      int unitproductSellingPrice,
      int unitProductCostPrice,
      int unitproductQuantity,
      int unitLimit,
      int packProductSellingPrice,
      int packProductCostPrice,
      int packQuantity,
      int packLimit,
      String barcode,
      String productDescription,
      String image,
      int productDiscount,
      int productWeight,
      double tax,
      List<ColorDataModel> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    ColorsData colorsData = ColorsData(colorDataModel: data);
    final String url = GlobalConfiguration().get("add-products") + '$branchId/';
    try {
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
                "price": unitproductSellingPrice,
                "quantity": unitproductQuantity,
                "limit": unitLimit,
                "cost_price": unitProductCostPrice,
              },
              "product_pack": {
                "price": packProductSellingPrice,
                "limit": unitLimit,
                "quantity": packQuantity,
                "cost_price": unitProductCostPrice
              },
              "image": image,
              "name": unitproductName,
              "tax": tax,
              "barcode": barcode,
              "description": productDescription,
              "weight": productWeight,
              "discount": productDiscount,
            }
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        sharedPreferences.setString('id', json.decode(response.body)['id']);
        return response.statusCode;
      } else if (json.decode(response.body)['detail'] ==
          "Given token not valid for any token type") {
        return false;
      } else {
        print(response.body);

        Map result = json.decode(response.body);
        String finalResult;
        result.forEach((k, v) {
          finalResult = ' ${v[0]}';
        });
        return finalResult;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Add products alone
  Future<dynamic> addProductToCategory(
    String unitproductName,
    int unitproductSellingPrice,
    int unitProductCostPrice,
    int unitproductQuantity,
    int unitLimit,
    int packProductSellingPrice,
    int packProductCostPrice,
    int packQuantity,
    int packLimit,
    String barcode,
    String productDescription,
    String image,
    int productDiscount,
    int productWeight,
    double tax,
    List<ColorDataModel> data,
    String categoryId,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    ColorsData colorsData = ColorsData(colorDataModel: data);
    final String url =
        GlobalConfiguration().get("product-category") + '$categoryId/';
    try {
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
              "price": unitproductSellingPrice,
              "quantity": unitproductQuantity,
              "limit": unitLimit,
              "cost_price": unitProductCostPrice
            },
            "product_pack": {
              "price": packProductSellingPrice,
              "limit": packLimit,
              "quantity": packQuantity,
              "cost_price": packProductCostPrice
            },
            "name": unitproductName,
            "image": image,
            "description": productDescription,
            "weight": productWeight,
            "tax": tax,
            "bar_code": barcode,
            "discount": productDiscount
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        Map result = json.decode(response.body);
        String finalResult;
        result.forEach((k, v) {
          finalResult = ' ${v[0]}';
        });
        return finalResult;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // //get products from firebase
  // Future<String> getFirebaseId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String firebaseId = sharedPreferences.getString("firebaseId");

  //   final dbRef = FirebaseDatabase.instance;
  //   dbRef.setPersistenceEnabled(true);
  //   dbRef.setPersistenceCacheSizeBytes(10000000);
  //   final databaseInstance = dbRef.reference();
  //   databaseInstance.keepSynced(true);
  //   List allProducts = [];
  //   return databaseInstance
  //       .child('inventories')
  //       .orderByKey()
  //       .equalTo(firebaseId)
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     Map<dynamic, dynamic> values = snapshot.value['$firebaseId'];
  //     print(values.toString());
  //     values.forEach((k, v) {
  //       print(v["name"]);
  //       print(v['products'].map((value) {
  //         print(value['name']);
  //       }));
  //     });
  //   });
  // }

  //update category

  Stream<Event> getFirebaseData(firebaseId) {
    final dbRef = FirebaseDatabase.instance; //firebase database reference
    dbRef.setPersistenceEnabled(true);
    dbRef.setPersistenceCacheSizeBytes(10000000);
    final databaseInstance = dbRef.reference();
    databaseInstance.keepSynced(true);
    final firebaseDb = databaseInstance
        .reference()
        .child('inventories')
        .orderByKey()
        .equalTo(firebaseId);
    return firebaseDb.onValue;
  }

  Stream<Event> getFirebaseNotification(firebaseId) {
    final dbRef = FirebaseDatabase.instance; //firebase database reference
    dbRef.setPersistenceEnabled(true);
    dbRef.setPersistenceCacheSizeBytes(10000000);
    final databaseInstance = dbRef.reference();
    databaseInstance.keepSynced(true);
    final firebaseDb = databaseInstance
        .reference()
        .child('notification')
        .orderByKey()
        .equalTo(firebaseId);
    return firebaseDb.onValue;
  }

  Future<dynamic> updateCategory(String categoryId, String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    print(name);
    print(categoryId);
    try {
      final String url =
          GlobalConfiguration().get("update-category") + '$categoryId/';

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
        return false;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> editProduct(
    String unitproductName,
    double unitproductPrice,
    int unitproductQuantity,
    int unitLimit,
    double unitCostPrice,
    double packProductPrice,
    int packQuantity,
    int packLimit,
    double packCostPrice,
    String barcode,
    String productDescription,
    int productDiscount,
    int productWeight,
    double tax,
    List<ColorDataModel> data,
    String productId,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    ColorsData colorsData = ColorsData(colorDataModel: data);
    print(packCostPrice);
    print(packProductPrice);
    print(productId);
    try {
      final String url =
          GlobalConfiguration().get("edit-product") + '$productId/';

      final response = await http.patch(url,
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
              "limit": unitLimit,
              "cost_price": unitCostPrice
            },
            "product_pack": {
              "price": packProductPrice,
              "limit": packLimit,
              "quantity": packQuantity,
              "cost_price": packCostPrice
            },
            "name": unitproductName,
            "description": productDescription,
            "weight": productWeight,
            "tax": tax,
            "bar_code": barcode,
            "discount": productDiscount
          }));
      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        print(response.body);
        return json.decode(response.body);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> deleteCategory(List<String> deleteItem) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    try {
      final String url = GlobalConfiguration().get("delete-category");
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
      print(response.statusCode);
      return response.statusCode;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> productFileUpload(String categoryId, File file) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String firebaseId = sharedPreferences.getString("firebaseId");
    print(file);
    String token = sharedPreferences.getString('token');
    print(firebaseId);
    print(categoryId.toString() + 'this is category');
    final String url =
        GlobalConfiguration().get("file-upload") + '$categoryId/$firebaseId/';

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

    if (response.statusCode != 200 || response.statusCode != 201) {
      Map result = json.decode(responseString);
      String finalResult;
      result.forEach((k, v) {
        finalResult = '$k: $v';
      });
      return finalResult;
    } else {
      return response.statusCode;
    }
  }

  Future<dynamic> updateBranch(
      String branchName, String branchAddress, bool notificationStatus) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    String firebaseId = sharedPreferences.getString("firebaseId");
    String firebaseNotificationId =
        sharedPreferences.getString("firebaseNotificationId");
    String businessId = sharedPreferences.getString("businessId");
    final String url =
        GlobalConfiguration().get("update-branch") + '$branchId/';

    try {
      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, dynamic>{
            "notification_status": notificationStatus,
            "name": branchName,
            "address": branchAddress,
            "firebase_inventory_id": firebaseId,
            "firebase_notification_id": firebaseNotificationId,
            "business_id": businessId
          }));

      if (response.statusCode != 200 || response.statusCode != 201) {
        print(response.body);
        return true;
      } else {
        print(response.body);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> deleteProducts(List<String> deleteItem) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("delete-product");
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
    print(response.statusCode);
    return response.statusCode;
  }

  Future<ProductList> getAllProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    print(branchId);
    String token = sharedPreferences.getString('token');
    print(token);
    final String url =
        GlobalConfiguration().get("get-all-products") + '$branchId/';

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
      print(response.body);
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
