import 'dart:convert';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/user_model.dart';

class AuthServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  getTokenz() async {
    String token = await _firebaseMessaging.getToken();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('firebaseToken', token);
  }

  Future<dynamic> userRegistration(
    String firstName,
    String lastName,
    String phone,
    String password,
    String email,
    String businessName,
    String businessAddress,
    String businessDescription,
    String businessType,
    String referralCode,
  ) async {
    getTokenz();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String firebaseToken = sharedPreferences.get('firebaseToken');
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
          "registration_id": firebaseToken,
          "name": businessName,
          "address": businessAddress,
          "description": businessDescription,
          "referral": referralCode,
          "business_type": businessType
        }));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      sharedPreferences.setString("token", responseJson['token']['access']);
      dynamic user = User.fromJson(json.decode(response.body));
      sharedPreferences.setString("branchId", user.branchId);
      sharedPreferences.setString("body", response.body);
      sharedPreferences.setString('user_id', user.user_id);
      sharedPreferences.setString('subscription_plan',
          responseJson['business'][0]['branch'][0]['subscription_plan']);
      sharedPreferences.setString(
          'firebaseNotificationId', user.firebaseNotificationId);
      sharedPreferences.setString('businessId', user.businessId);

      print(user.branchId);
      return user;
    } else {
      print(response.body);
      print(response.statusCode);
      return null;
    }
  }

  Future<dynamic> loginUsernew(
    String username,
    String password,
  ) async {
    getTokenz();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String firebaseToken = sharedPreferences.get('firebaseToken');
    final http.Response response = await http.post(
      'http://stockfare-io.herokuapp.com/api/v1/users/login/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
        "registration_id": firebaseToken
      }),
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      sharedPreferences.setString("token", responseJson['token']['access']);
      dynamic user = User.fromJson(json.decode(response.body));
      sharedPreferences.setString("branchId", user.branchId);
      sharedPreferences.setString("body", response.body);
      sharedPreferences.setString("firebaseId", user.firebaseId);
      sharedPreferences.setString('user_id', user.userId.toString());
      sharedPreferences.setString('subscription_plan',
          responseJson['business'][0]['branch'][0]['subscription_plan']);
      sharedPreferences.setString(
          'firebaseNotificationId', user.firebaseNotificationId);
      sharedPreferences.setString('businessId', user.businessId);

      return user;
    } else if (response.statusCode == 400) {
      print(response.body);
      return null;
    }
  }

  Future<dynamic> forgotPassword(String data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    final String url =
        'http://stockfare-io.herokuapp.com/api/v1/users/forgot-password/';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          "data": data,
        }));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      sharedPreferences.setString('queryToken', responseJson['token']);
      sharedPreferences.setString('email', responseJson['email']);

      print(responseJson);
      return true;
    } else {
      print(response.body);
      print(response.statusCode);
      return false;
    }
  }

  Future<dynamic> updatePassword(String oldPassword, String newPassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    final String url =
        'http://stockfare-io.herokuapp.com/api/v1/users/change-password/';
    final http.Response response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          "old_password": oldPassword,
          "new_password": newPassword
        }));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      return response.statusCode;
    } else {
      print(response.body);
      print(response.statusCode);
      return response.body;
    }
  }

  Future<dynamic> verifyPasswordCode(String code, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String queryToken = sharedPreferences.getString('queryToken');
    String queryEmail = sharedPreferences.getString('email');
    print(code);
    var queryParameters = {
      'token': queryToken,
      'email': queryEmail,
    };
    var uri = Uri.https('stockfare-io.herokuapp.com',
        '/api/v1/users/verify-code/', queryParameters);
    final http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{"code": code, "password": password}));
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      print(response.statusCode);
      return json.decode(response.body)['message'];
    }
  }

  Future<dynamic> verifyPhone(String code) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String token = sharedPreferences.getString('token');
    final String url =
        'http://stockfare-io.herokuapp.com/api/v1/users/verify-phone-number/';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          "code": code,
        }));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      return true;
    } else {
      print(response.body);
      print(response.statusCode);
      return false;
    }
  }

  Future<dynamic> updateDetails(String firstName, String lastName,
      String emailAddress, String phoneNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('user_id');
    String token = sharedPreferences.getString('token');
    print(phoneNumber);
    final String url =
        'http://stockfare-io.herokuapp.com/api/v1/users/update-detail/$userId/';
    final http.Response response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          "first_name": firstName,
          "last_name": lastName,
          "email": emailAddress,
          "phone_number": phoneNumber
        }));

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      return response.statusCode;
    } else {
      return response.body;
    }
  }
}
