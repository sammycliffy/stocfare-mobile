import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/analytics_model.dart';

class Analytics {
  Future<ProductAnalytics> getAllAnalytics() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    print(token);
    final String url =
        'https://stockfare-io.herokuapp.com/api/v1/analytics/sale-analysis/8e044e8c-263b-40f7-afb7-601154b59601/';
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return ProductAnalytics.fromJson(json.decode(response.body));
    } else {
      throw Exception('Could not get Analytics');
    }
  }
}
