import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/activities_model.dart';

class ActivitiesServices {
  Future<ActivitiesModel> getAllActivities() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');

    String url =
        'https://stockfare-io.herokuapp.com/api/v1/dashboard/$branchId';

    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return ActivitiesModel.fromJson(json.decode(response.body));

      // print(result.activities.map((e) {
      //   return e.description;
      // }));
    } else {
      throw Exception('Could not load Activties');
    }
  }
}
