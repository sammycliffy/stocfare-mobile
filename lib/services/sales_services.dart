import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:stockfare_mobile/models/create_sales_model.dart';
import 'dart:convert';

import 'package:stockfare_mobile/models/sales_model.dart';

class SalesServices {
  Future<GetSalesModel> getallSales() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        'https://stockfare-io.herokuapp.com/api/v1/sales/sales/$branchId/';
    final http.Response response =
        await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      return GetSalesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<GetSalesModel> sortedDates(int sortedDate) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    print(sortedDate);
    final String url =
        'https://stockfare-io.herokuapp.com/api/v1/sales/sales/$branchId/?date=$sortedDate';
    final http.Response response =
        await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      return GetSalesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<CreateSalesModel> addSales(
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
      int tax,
      dynamic date) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    print(token);
    print(products);
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
          "colours": [],
          "amount_paid": amountPaid,
          "ref_code": null
        }));
    if (response.statusCode == 200) {
      return CreateSalesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('somthing went wrong');
    }
  }
}
