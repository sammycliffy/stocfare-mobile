import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/all_expenses_model.dart';
import 'package:stockfare_mobile/models/expenses-summary.dart';

class ExpensesServices {
  DioCacheManager _dioCacheManager;
  Future createExpenses(
      String amount, String note, String expenses, String date) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("create-expenses") + '$branchId/';
    try {
      final http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, String>{
            "amount": amount,
            "date": date,
            "note": note,
            "expense_made_on": expenses
          }));
      if (response.statusCode == 201) {
        print(response.body);
        return response.statusCode;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future createIncome(
      String amount, String note, String title, String date) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("create-income") + '$branchId/';
    try {
      final http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, String>{
            "amount": amount,
            "date": date,
            "note": note,
            "expense_made_on": title
          }));
      if (response.statusCode == 201) {
        print(response.body);
        return response.statusCode;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ExpensesSummary> getExpenseSummary() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-expenses-summary") + '$branchId/';
    Options _cacheOptions = buildCacheOptions(
      Duration(seconds: 180),
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
        return ExpensesSummary.fromJson(response.data);
      } else {
        print(response.statusCode);
        return Future.error(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<GetAllExpenses>> getAllExpenses() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-all-expenses") + '$branchId/';
    Options _cacheOptions = buildCacheOptions(
      Duration(seconds: 180),
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
        List<GetAllExpenses> _expenses = [];
        for (var i in response.data) {
          _expenses.add(GetAllExpenses.fromJson(i));
        }

        return _expenses;
      } else {
        print(response.statusCode);
        return Future.error(response.data);
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

  Future<ExpensesSummary> getIncomeSummary() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-income-summary") + '$branchId/';
    Options _cacheOptions = buildCacheOptions(
      Duration(seconds: 180),
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
        return ExpensesSummary.fromJson(response.data);
      } else {
        print(response.statusCode);
        return Future.error(response.data);
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

  Future<List<GetAllExpenses>> getAllIncome() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-all-income") + '$branchId/';
    Options _cacheOptions = buildCacheOptions(
      Duration(seconds: 180),
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
        List<GetAllExpenses> _expenses = [];
        for (var i in response.data) {
          _expenses.add(GetAllExpenses.fromJson(i));
        }
        return _expenses;
      } else {
        print(response.statusCode);
        return Future.error(response.data);
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

  Future<List<String>> getExpenseDropdown() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("expenses-dropdown") + '$branchId/';
    Options _cacheOptions = buildCacheOptions(
      Duration(seconds: 180),
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
        List<String> data = unpack(response.data);
        return data;
      } else {
        print(response.statusCode);
        return Future.error(response.data['detail']);
      }
    } catch (e) {
      if (e is DioError) {
        return Future.error(e.response.data['detail']);
      } else {
        print(e.toString());
      }
      //return e
    }
  }

  Future<List<String>> getIncomeDropdown() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("income-dropdown") + '$branchId/';
    Options _cacheOptions = buildCacheOptions(
      Duration(seconds: 180),
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
        List<String> data = unpack(response.data);
        return data;
      } else {
        print(response.statusCode);
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

  refreshgetExpensesAndSummary() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url =
        GlobalConfiguration().get("income-dropdown") + '$branchId/';
    final String url1 =
        GlobalConfiguration().get("expenses-dropdown") + '$branchId/';
    final String url2 =
        GlobalConfiguration().get("get-all-income") + '$branchId/';
    final String url3 =
        GlobalConfiguration().get("get-all-expenses") + '$branchId/';
    final String url4 =
        GlobalConfiguration().get("get-income-summary") + '$branchId/';
    final String url5 =
        GlobalConfiguration().get("get-expenses-summary") + '$branchId/';

    _dioCacheManager.deleteByPrimaryKey(url, requestMethod: "GET");
    _dioCacheManager.deleteByPrimaryKey(url1, requestMethod: "GET");
    _dioCacheManager.deleteByPrimaryKey(url2, requestMethod: "GET");
    _dioCacheManager.deleteByPrimaryKey(url3, requestMethod: "GET");
    _dioCacheManager.deleteByPrimaryKey(url4, requestMethod: "GET");
    _dioCacheManager.deleteByPrimaryKey(url5, requestMethod: "GET");
  }

  Future<ExpensesSummary> reOccuringExpenses() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("reoccuring-expenses") + '$branchId/';
    try {
      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.statusCode);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

unpack(list) {
  List<String> newList = [];
  for (var i in list) {
    newList.add(i);
  }
  return newList;
}
