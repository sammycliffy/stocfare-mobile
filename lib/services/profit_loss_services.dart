import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/expenses-summary.dart';
import 'package:http/http.dart' as http;
import 'package:stockfare_mobile/models/loss_model.dart';
import 'package:stockfare_mobile/models/profit.dart';

class ProfitAndLoss {
  Future<List<ProfitModel>> getProfitList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("profit-list") + '$branchId/';
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
        List<ProfitModel> _model = [];
        List<dynamic> _jsonResonse = json.decode(response.body);
        for (var i in _jsonResonse) {
          _model.add(ProfitModel.fromJson(i));
        }
        return _model;
      } else {
        print(response.statusCode);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<LossModel>> getLossList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("loss-list") + '$branchId/';
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
        List<LossModel> _model = [];
        List<dynamic> _jsonResonse = json.decode(response.body);
        for (var i in _jsonResonse) {
          _model.add(LossModel.fromJson(i));
        }
        return _model;
      } else {
        print(response.statusCode);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ExpensesSummary> getAllLoss() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-all-losses") + '$branchId/';
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
        return ExpensesSummary.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ExpensesSummary> getAllProfit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-all-profits") + '$branchId/';
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
        return ExpensesSummary.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
