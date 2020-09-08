import 'dart:convert';
import 'dart:async';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentServices {
  Future<dynamic> sendPaymentToServer(String subscriptionPlan) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String reference = sharedPreferences.getString('reference');
    String branchId = sharedPreferences.getString('branchId');
    print(promoCode);
    final String url = GlobalConfiguration().get("send-payment") + '$branchId/';
    try {
      final http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, String>{
            "subscription_plan": subscriptionPlan,
            "txref_code": reference
          }));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        return json.decode(response.body)['message'];
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<String> checkForPlan() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String subscriptionPlan = sharedPreferences.getString('subscription_plan');
    return subscriptionPlan;
  }

  Future<dynamic> switchPlan(String subscriptionPlan) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    print(promoCode);
    final String url = GlobalConfiguration().get("send-payment") + '$branchId/';
    try {
      final http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, String>{
            "subscription_plan": subscriptionPlan,
            "txref_code": null
          }));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> promoCode(String promoCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    print(promoCode);
    final String url = GlobalConfiguration().get("promo-code") + '$branchId/';
    try {
      final http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, String>{
            "promo_code": promoCode,
          }));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        print(response.statusCode);
        return false;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
