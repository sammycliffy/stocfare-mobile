import 'dart:async';
import 'dart:convert';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/all_expenses_model.dart';
import 'package:stockfare_mobile/models/expenses-summary.dart';

class ExpensesServices {
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-expenses-summary") + '$branchId/';
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
        return ExpensesSummary.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
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

  Future<ExpensesSummary> getIncomeSummary() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-income-summary") + '$branchId/';
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
        return ExpensesSummary.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<GetAllExpenses>> getAllExpenses() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-all-expenses") + '$branchId/';
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
        List<GetAllExpenses> _expenses = [];
        for (var i in json.decode(response.body)) {
          _expenses.add(GetAllExpenses.fromJson(i));
        }

        return _expenses;
      } else {
        print(response.statusCode);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<GetAllExpenses>> getAllIncome() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("get-all-income") + '$branchId/';
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
        List<GetAllExpenses> _expenses = [];
        for (var i in json.decode(response.body)) {
          _expenses.add(GetAllExpenses.fromJson(i));
        }
        return _expenses;
      } else {
        print(response.statusCode);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>> getExpenseDropdown() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("expenses-dropdown") + '$branchId/';
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
        List<String> data = unpack(json.decode(response.body));
        return data;
      } else {
        print(response.statusCode);
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>> getIncomeDropdown() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("income-dropdown") + '$branchId/';
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
        List<String> data = unpack(json.decode(response.body));
        return data;
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
