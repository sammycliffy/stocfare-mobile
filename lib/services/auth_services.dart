import 'dart:convert';
import 'dart:async';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/user_model.dart';

class AuthServices {
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String firebaseToken = sharedPreferences.get('firebaseToken');
    print(firebaseToken);

    try {
      final String url = GlobalConfiguration().get("signup");

      final http.Response response = await http
          .post(url,
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
              }))
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        sharedPreferences.setString("token", responseJson['token']['access']);
        dynamic user = User.fromJson(json.decode(response.body));
        sharedPreferences.setString("branchId", user.branchId);
        sharedPreferences.setString("body", response.body);
        sharedPreferences.setString("firebaseId", user.firebaseId);
        sharedPreferences.setBool('verified', user.verified);
        sharedPreferences.setInt('user_id', user.userId);
        sharedPreferences.setString('subscription_plan',
            responseJson['business'][0]['branch'][0]['subscription_plan']);
        sharedPreferences.setString(
            'firebaseNotificationId', user.firebaseNotificationId);
        sharedPreferences.setString('businessId', user.businessId);

        return true;
      } else {
        print(response.body);
        return json.decode(response.body)['name'] ??
            json.decode(response.body)['registration_id'] ??
            json.decode(response.body)['account']['phone_number'] ??
            json.decode(response.body)['account']['email'] ??
            json.decode(response.body)['account']['error'];

        // return json.decode(response.body);
      }
    } on TimeoutException catch (e) {
      print(e.toString());
      return null;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> loginUsernew(
    String username,
    String password,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String firebaseToken = sharedPreferences.get('firebaseToken');
    String url = GlobalConfiguration().get("login");
    print(url);
    try {
      final http.Response response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "username": username,
              "password": password,
              "registration_id": firebaseToken
            }),
          )
          .timeout(Duration(seconds: 15));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        sharedPreferences.setString("token", responseJson['token']['access']);
        dynamic user = User.fromJson(json.decode(response.body));
        sharedPreferences.setString("branchId", user.branchId);
        sharedPreferences.setString("body", response.body);
        sharedPreferences.setBool("verified", user.verified);
        sharedPreferences.setString("firebaseId", user.firebaseId);
        sharedPreferences.setString('user_id', user.userId.toString());
        sharedPreferences.setString('subscription_plan', user.subscriptionPlan);
        sharedPreferences.setString(
            'firebaseNotificationId', user.firebaseNotificationId);
        sharedPreferences.setString('businessId', user.businessId);

        return true;
      } else {
        return json.decode(response.body)['error'];
        // return json.decode(response.body);
      }
    } on TimeoutException catch (e) {
      print(e.toString());
      return null;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> loginUserold(
    String password,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String firebaseToken = sharedPreferences.get('firebaseToken');
    String body = sharedPreferences.getString('body');
    dynamic user = User.fromJson(json.decode(body));
    String url = GlobalConfiguration().get("login");
    print(url);
    try {
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "username": user.phone,
          "password": password,
          "registration_id": firebaseToken
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        sharedPreferences.setString("token", responseJson['token']['access']);
        dynamic user = User.fromJson(json.decode(response.body));
        sharedPreferences.setString("branchId", user.branchId);
        sharedPreferences.setString("body", response.body);
        sharedPreferences.setBool("verified", user.verified);
        sharedPreferences.setString("firebaseId", user.firebaseId);
        sharedPreferences.setString('user_id', user.userId.toString());
        sharedPreferences.setString('subscription_plan', user.subscriptionPlan);
        sharedPreferences.setString(
            'firebaseNotificationId', user.firebaseNotificationId);
        sharedPreferences.setString('businessId', user.businessId);

        return true;
      } else {
        return json.decode(response.body)['error'];
        // return json.decode(response.body);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> forgotPassword(String data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    print(data);
    final String url = GlobalConfiguration().get("forgot-password");
    try {
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
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> resendCode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String body = sharedPreferences.getString('body');
    dynamic user = User.fromJson(json.decode(body));

    final String url = GlobalConfiguration().get("forgot-password");
    try {
      final http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, String>{
            "data": user.phone,
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
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> updatePassword(String oldPassword, String newPassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("change-password");
    try {
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
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> verifyPasswordCode(String code, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    String queryToken = sharedPreferences.getString('queryToken');
    String queryEmail = sharedPreferences.getString('email');
    print(queryEmail);
    print(code);
    var queryParameters = {
      'token': queryToken,
      'email': queryEmail,
    };
    var uri = Uri.https('https://api-lexical-dance.stockfare_mobile.co',
        '/api/v1/users/verify-code/', queryParameters);
    try {
      final http.Response response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body:
              jsonEncode(<String, String>{"code": code, "password": password}));
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        print(response.statusCode);
        return json.decode(response.body)['message'];
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> verifyPhone(String code) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("verify-phone");
    try {
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
        return json.decode(response.body);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> updateDetails(String firstName, String lastName,
      String emailAddress, String phoneNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('user_id');
    String token = sharedPreferences.getString('token');
    print(phoneNumber);
    final String url = GlobalConfiguration().get("update-detail") + '$userId/';
    try {
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
        return json.decode(response.body)['name'] ??
            json.decode(response.body)['phone_number'] ??
            json.decode(response.body)['email'] ??
            ' ';
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
