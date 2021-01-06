import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/expenses-summary.dart';
import 'package:stockfare_mobile/models/loss_model.dart';
import 'package:stockfare_mobile/models/profit.dart';

class ProfitAndLoss {
  DioCacheManager _dioCacheManager;
  Future<List<ProfitModel>> getProfitList() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("profit-list") + '$branchId/';

    try {
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(
        Duration(seconds: 120),
      );
      _cacheOptions.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager.interceptor);
      Response response = await _dio.get(url, options: _cacheOptions);
      if (response.statusCode == 200) {
        List<ProfitModel> _model = [];
        List<dynamic> _jsonResonse = response.data;
        for (var i in _jsonResonse) {
          _model.add(ProfitModel.fromJson(i));
        }
        return _model;
      } else {
        print(response.statusCode);
        return Future.error(response.data['detail']);
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response.data);
        var result;
        e.response.data == null
            ? result = 'Network Error'
            : result = e.response.data['detail'];
        return Future.error(result);
      } else {
        print(e.toString());
      }
      //return e
    }
  }

  Future<List<LossModel>> getLossList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("loss-list") + '$branchId/';
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
        List<LossModel> _model = [];
        List<dynamic> _jsonResonse = response.data;
        for (var i in _jsonResonse) {
          _model.add(LossModel.fromJson(i));
        }
        print(response.data);
        return _model;
      } else {
        print(response.statusCode);
        return Future.error(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response.data);
        var result;
        e.response.data == null
            ? result = 'Network Error'
            : result = e.response.data['detail'];
        return Future.error(result);
      } else {
        print(e.toString());
      }
      //return e
    }
  }

  Future<ExpensesSummary> getAllLoss() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-all-losses") + '$branchId/';
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
        return ExpensesSummary.fromJson(response.data);
      } else {
        print(response.statusCode);
        return Future.error(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response.data);
        var result;
        e.response.data == null
            ? result = 'Network Error'
            : result = e.response.data['detail'];
        return Future.error(result);
      } else {
        print(e.toString());
      }
      //return e
    }
  }

  Future<ExpensesSummary> getAllProfit() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-all-profits") + '$branchId/';
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
        return ExpensesSummary.fromJson(response.data);
      } else {
        print(response.statusCode);
        return Future.error(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response.data);
        var result;
        e.response.data == null
            ? result = 'Network Error'
            : result = e.response.data['detail'];
        return Future.error(result);
      } else {
        print(e.toString());
      }
      //return e
    }
  }
}
