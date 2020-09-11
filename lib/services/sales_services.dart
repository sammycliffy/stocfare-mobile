import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:stockfare_mobile/models/create_sales_model.dart';
import 'dart:convert';

import 'package:stockfare_mobile/models/sales_model.dart';

class SalesServices {
  Future<GetSalesModel> getallSales(int pageNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    String pageData;
    pageNumber == 1 ? pageData = '' : pageData = '?page=$pageNumber';
    final String url =
        GlobalConfiguration().get("get-sales") + '$branchId/$pageData';
    try {
      final http.Response response =
          await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return GetSalesModel.fromJson(json.decode(response.body));
      } else {
        return Future.error(json.decode(response.body)['detail']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<GetSalesModel> getSalesPages(int pageNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-sales") + '$branchId/?page=$pageNumber';
    try {
      final http.Response response =
          await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return GetSalesModel.fromJson(json.decode(response.body));
      } else {
        return Future.error(json.decode(response.body)['detail']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<GetSalesModel> sortedDates(int sortedDate) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    print(sortedDate);
    try {
      final String url = GlobalConfiguration().get("get-sales") +
          '$branchId/?date=$sortedDate';
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
        return Future.error('error');
      }
    } catch (e) {
      print(e.tostring());
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
    dynamic date,
    int total,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    print(token);
    print(products);
    final String url = GlobalConfiguration().get("create-sales") + '$branchId/';
    try {
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
            "amount": total,
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
        print(response.body);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> deleteSales(String id) async {
    print(id);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("delete-sales") + '$id/';
    try {
      final http.Response response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 204) {
        print(response.statusCode);
        return response.statusCode;
      } else {
        print(response.body);
        return json.decode(response.body)['detail'];
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
