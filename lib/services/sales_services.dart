import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stockfare_mobile/models/sales_model.dart';

class SalesServices {
  Future<Welcome> getallSales() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        'https://stockfare-io.herokuapp.com/api/v1/sales/sales/8e044e8c-263b-40f7-afb7-601154b59601';
    final http.Response response =
        await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      return Welcome.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Welcome> sortedDates(int sortedDate) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    print(sortedDate);
    final String url =
        'https://stockfare-io.herokuapp.com/api/v1/sales/sales/8e044e8c-263b-40f7-afb7-601154b59601/?date=$sortedDate';
    final http.Response response =
        await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      return Welcome.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Welcome> addSales(
      List products,
      String customerName,
      String customerAddress,
      String customerMobile,
      String customerEmail,
      int productAmount,
      int customerChange,
      String paymentMethod,
      bool soldOnCredit,
      int amountPaid,
      int tax) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        'http://stockfare-io.herokuapp.com/api/v1/sales/create-sale/$branchId/';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(<String, dynamic>{
          "products": products,
          "customer": {
            "name": customerName,
            "address": customerAddress,
            "mobile": customerMobile,
            "email": customerEmail,
            "updated_at": null
          },
          "amount": productAmount,
          "change": customerChange,
          "payment_method": paymentMethod,
          "sold_on_credit": soldOnCredit,
          "tax": tax,
          "amount_paid": amountPaid,
          "ref_code": ""
        }));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}

// List result = [];
// List name = [];
// List dateCreated = [];
// List prices = [];

// print(sales.results.map((i) {
//   return i.productData.map((name) {
//     result.add(name.name);
//     result.add(name.dateCreated);
//     result.add('Product Unit Price ' + name.productUnit.price.toString());
//     result.add(
//         'Product Unit Quantity ' + name.productUnit.quantity.toString());
//   });
// }));

// print(sales.results.map((i) {
//   result.add('Seller' + i.saleRegisteredBy.toString());
//   i.productDetail.map((cost) {
//     result.add('total cost' + cost.totalCost.toString());
//   });
// }));
