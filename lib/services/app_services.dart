import 'dart:async';
import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

class AppServices {
  Future<String> getAppVersion() async {
    final String url = GlobalConfiguration().get("version-number");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      ).timeout(Duration(seconds: 4));
      if (response.statusCode == 200) {
        print(json.decode(response.body)["versionCode"]);
        return json.decode(response.body)["versionCode"];
      } else {
        print(response.body);
        print(response.statusCode);
        return Future.error(json.decode(response.body)['detail']);
      }
    } on TimeoutException catch (e) {
      print(e.toString());
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
