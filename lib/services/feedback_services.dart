import 'dart:async';
import 'dart:convert';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FeedBackServices {
  Future<int> feedBackServices(String feedBack) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');

    String url = GlobalConfiguration().get("feedback");

    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{"message": feedBack}));

    if (response.statusCode == 201) {
      return response.statusCode;

      // print(result.activities.map((e) {
      //   return e.description;
      // }));
    } else {
      print(response.body);
      print(response.statusCode);
      return response.statusCode;
    }
  }
}
