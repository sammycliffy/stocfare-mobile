import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/user_model.dart';

class AuthServices {
  Future<dynamic> productAddition(
    String productName,
    String firebaseId,
    String productColor,
    String productUnit,
    String productId,
    String productPrice,
    String productQuantity,
    String productLimit,
    String productPackId,
    String productPackPrice,
    String productPackLimit,
    String productPackQuantity,
    String productPackUnit,
    String barcode,
    String productDescription,
  ) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String url =
          'http://stockfare-io.herokuapp.com/api/v2/users/register/';
      final http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "account": {
              "first_name": firstName,
              "last_name": lastName,
              "phone_number": email,
              "email": phone,
              "password": password,
            },
            "registration_id": registrationId,
            "name": businessName,
            "address": businessAddress,
            "description": businessDescription,
            "referral": referralCode,
            "business_type": businessType
          }));
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        sharedPreferences.setString("token", responseJson['token']['access']);
        print(responseJson);
        //sharedPreferences.setString("token", responseJson['token']['access']);
        dynamic user = User.fromJson(json.decode(response.body)['user']);
        return user;
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print('no internet connection');
    }
  }
}
