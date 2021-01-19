import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/analytics_model.dart';
import 'package:stockfare_mobile/models/product_analytics_model.dart';
import 'package:stockfare_mobile/models/products_analytics_model.dart';
import 'package:stockfare_mobile/models/sales_analytics_model.dart';

class Analytics {
  DioCacheManager _dioCacheManager;

  Future<SalesAnalytics> getAllAnalytics() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url =
        GlobalConfiguration().get("get-analytics") + '$branchId/';
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
        return SalesAnalytics.fromJson(response.data);
      } else {
        print(response.data);
        return Future.error(response.data['detail']);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        return Future.error('Network Issue');
      } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        return Future.error('Network Issue');
      }
    } on SocketException catch (e) {
      return Future.error('Network Issue');
    }
  }

  refreshGetAllAnalytics() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url =
        GlobalConfiguration().get("get-analytics") + '$branchId/';

    _dioCacheManager.deleteByPrimaryKey(url, requestMethod: "GET");
    getAllAnalytics();
  }

  Future<ProductsAnalyticsModel> getAllProducts() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url =
        GlobalConfiguration().get("get-product-analytics") + '$branchId/';
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
        return ProductsAnalyticsModel.fromJson(response.data);
      } else {
        return Future.error(response.data['detail']);
      }
    } on DioError catch (e) {
      print(e.toString);
    }
  }

  refreshgetAllProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url =
        GlobalConfiguration().get("get-product-analytics") + '$branchId/';

    _dioCacheManager.deleteByPrimaryKey(url, requestMethod: "GET");
    getAllProducts();
  }

  Future<SalesAnalyticsModel> analyticsDetails(String filterBy) async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url = GlobalConfiguration().get("analytics-details") +
        '$branchId/?filter_by=$filterBy';
    Options _cacheOptions = buildCacheOptions(
      Duration(seconds: 120),
    );
    _cacheOptions.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    _cacheOptions.receiveTimeout = 3000;
    try {
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager.interceptor);
      Response response = await _dio.get(url, options: _cacheOptions);
      if (response.statusCode == 200) {
        print(response.data);
        return SalesAnalyticsModel.fromJson(response.data);
      } else {
        return Future.error(response.data['detail']);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        return Future.error('Network Issue');
      } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        return Future.error('Network Issue');
      }
    }
  }

  Future<ProductsAnalyticsList> productsAnalyticsDetails(
      String filterBy) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url = GlobalConfiguration().get("product-analytics-details") +
        '$branchId/?filter_by=$filterBy';
    Options _cacheOptions = buildCacheOptions(
      Duration(seconds: 120),
    );
    try {
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager.interceptor);
      Response response = await _dio.get(url, options: _cacheOptions);
      if (response.statusCode == 200) {
        print(response.data);
        return ProductsAnalyticsList.fromJson(response.data);
      } else {
        return Future.error(response.data['detail']);
      }
    } on DioError catch (e) {
      print(e.toString);
    }
  }

  Future<SalesAnalyticsModel> analyticsDetailsPage(
      String filterBy, pageNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url = GlobalConfiguration().get("analytics-details") +
        '$branchId/?filter_by=$filterBy&page=$pageNumber';
    Options _cacheOptions = buildCacheOptions(
      Duration(seconds: 120),
    );

    try {
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager.interceptor);
      Response response = await _dio.get(url, options: _cacheOptions);
      if (response.statusCode == 200) {
        print(response.data);
        return SalesAnalyticsModel.fromJson(response.data);
      } else {
        return Future.error(response.data['detail']);
      }
    } on DioError catch (e) {
      print(e.toString);
    }
  }

  Future<ProductsAnalyticsList> productsAnalyticsDetailsPage(
      String filterBy, pageNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url = GlobalConfiguration().get("product-analytics-details") +
        '$branchId/?filter_by=$filterBy&page=$pageNumber';

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
        return ProductsAnalyticsList.fromJson(response.data);
      } else {
        return Future.error(response.data['detail']);
      }
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}
