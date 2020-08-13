import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:stockfare_mobile/models/workers_models.dart';

class WorkersServices {
  Future<WorkersList> getListOfWorkers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');

    final String url =
        'https://stockfare-io.herokuapp.com/api/v1/agents/$branchId';
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return WorkersList.fromJson(json.decode(response.body));
    } else {
      throw ('this is wwong');
    }
  }

  Future<dynamic> addWorkers(
      String firstName,
      String lastName,
      String phoneNumber,
      String emailAddress,
      String password,
      List roles) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');

    final String url =
        'https://stockfare-io.herokuapp.com/api/v1/agents/register-worker/$branchId/';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "account": {
            "first_name": firstName,
            "last_name": lastName,
            "phone_number": phoneNumber,
            "email": emailAddress,
            "password": password,
          },
          "roles": roles,
          "branch_id": branchId
        }));
    if (response.statusCode == 201) {
      return WorkersList.fromJson(json.decode(response.body));
    } else {
      dynamic result = json.decode(response.body);
      return result['account'];
    }
  }
}
