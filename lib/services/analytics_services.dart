import 'dart:convert';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/analytics_model.dart';
import 'package:stockfare_mobile/models/product_analytics_model.dart';
import 'package:stockfare_mobile/models/products_analytics_model.dart';
import 'package:stockfare_mobile/models/sales_analytics_model.dart';

class Analytics {
  Future<SalesAnalytics> getAllAnalytics() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url =
        GlobalConfiguration().get("get-analytics") + '$branchId/';
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return SalesAnalytics.fromJson(json.decode(response.body));
      } else {
        print(response.body);
        return Future.error(json.decode(response.body)['detail']);
      }
    } catch (e) {
      print(e.toString);
    }
  }

  Future<ProductsAnalyticsModel> getAllProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url =
        GlobalConfiguration().get("get-product-analytics") + '$branchId/';
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return ProductsAnalyticsModel.fromJson(json.decode(response.body));
      } else {
        print(response.body);
        return Future.error(json.decode(response.body)['detail']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<SalesAnalyticsModel> analyticsDetails(String filterBy) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url = GlobalConfiguration().get("analytics-details") +
        '$branchId/?filter_by=$filterBy';
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return SalesAnalyticsModel.fromJson(json.decode(response.body));
      } else {
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ProductsAnalyticsList> productsAnalyticsDetails(
      String filterBy) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url = GlobalConfiguration().get("product-analytics-details") +
        '$branchId/?filter_by=$filterBy';
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return ProductsAnalyticsList.fromJson(json.decode(response.body));
      } else {
        print(response.body);
        return Future.error('error');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
