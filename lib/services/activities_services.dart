import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/activities_model.dart';

class ActivitiesServices {
  Future<ActivitiesModel> getAllActivities() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');

    String url = GlobalConfiguration().get("activities") + '$branchId/';

    try {
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
        return Future.error(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString);
    }
  }

  Future<bool> checkForInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
