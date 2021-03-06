import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:stockfare_mobile/models/create_sales_model.dart';
import 'dart:convert';
import 'package:stockfare_mobile/models/sales_model.dart';

import 'analytics_services.dart';

class SalesServices {
  DioCacheManager _dioCacheManager;
  Analytics _checkSales = Analytics();
  Future<GetSalesModel> getallSales() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("get-sales") + '$branchId/';

    Options _cacheOptions = buildCacheOptions(
      Duration(seconds: 120),
    );
    _cacheOptions.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    try {
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager.interceptor);
      Response response = await _dio.get(url, options: _cacheOptions);
      if (response.statusCode == 200) {
        print(response.data);
        return GetSalesModel.fromJson(response.data);
      } else {
        return Future.error(response.data['detail']);
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response.data);
        return Future.error(e.response.data['detail']);
      } else {
        print(e.toString());
      }
      //return e
    }
  }

  refreshgetallSales() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url = GlobalConfiguration().get("get-sales") + '$branchId/';

    _dioCacheManager.deleteByPrimaryKey(url, requestMethod: "GET");
  }

  Future versionNumber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("version-number");
    try {
      final http.Response response =
          await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
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
        print(response.body);
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
      print(e);
    }
  }

  Future<dynamic> getSalesReport(int startDate, int endDate, email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    try {
      final String url = GlobalConfiguration().get("sales-report") +
          '$branchId/?start_date=$startDate&end_date=$endDate';
      final http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(<String, String>{'email': email}));
      if (response.statusCode == 200) {
        print(response.body);
        return response.statusCode;
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<GetSalesModel> sortedDatePages(int sortedDate, pageNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    print(sortedDate);
    try {
      final String url = GlobalConfiguration().get("get-sales") +
          '$branchId/?date=$sortedDate&page=$pageNumber';
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
      print(e);
    }
  }

  Future<dynamic> addSales(
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
    String _error = '';
    try {
      print(url);
      final http.Response response = await http
          .post(url,
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
              }))
          .timeout(Duration(seconds: 25), onTimeout: () => null);
      if (response.statusCode == 200) {
        print(response.body);
        return CreateSalesModel.fromJson(json.decode(response.body));
      } else {
        Map result = json.decode(response.body);
        print(response.statusCode);
        result.forEach((k, v) {
          _error = '$k $v';
        });
        return _error;
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
