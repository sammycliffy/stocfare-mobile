import 'dart:convert';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:stockfare_mobile/models/workers_models.dart';

class WorkersServices {
  Future<WorkersList> getListOfWorkers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url =
        GlobalConfiguration().get("get-workers-list") + '$branchId/';
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
        // print(response.body);
        return WorkersList.fromJson(json.decode(response.body));
      } else {
        print(response.body);
        print(response.statusCode);
        return Future.error(json.decode(response.body)['detail']);
      }
    } catch (e) {
      print(e.toString());
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
    final String url = GlobalConfiguration().get("add-worker") + '$branchId/';
    try {
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
        return true;
      } else {
        print(response.body);
        return json.decode(response.body)['name'] ??
            json.decode(response.body)['account']['phone_number'] ??
            json.decode(response.body)['account']['email'] ??
            ' ';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> deleteWorker(String id) async {
    print(id);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    final String url =
        GlobalConfiguration().get("delete-worker") + '$branchId/$id/';
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
        return json.decode(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> editWorkers(String id, String password, List roles) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    print(id);
    print(password);
    print(roles);
    final String url =
        GlobalConfiguration().get("edit-worker") + '$branchId/$id/';

    try {
      final http.Response response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(
              <String, dynamic>{"role": roles, "password": password}));
      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        print(response.body);
        return response.body;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
