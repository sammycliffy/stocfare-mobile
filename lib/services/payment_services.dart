import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentServices {
  Future<dynamic> sendPaymentToServer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String reference = sharedPreferences.getString('reference');
    String subscriptionPlan = sharedPreferences.getString('subscription_plan');
    String branchId = sharedPreferences.getString('branchId');
    print(promoCode);
    final String url =
        'http://stockfare-io.herokuapp.com/api/v1/subscription/switch-plan/$branchId/';
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
      print(response.statusCode);
      return false;
    }
  }

  Future<dynamic> promoCode(String promoCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String branchId = sharedPreferences.getString('branchId');
    print(promoCode);
    final String url =
        'http://stockfare-io.herokuapp.com/api/v1/promotion/submit/$branchId/';
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
  }
}
