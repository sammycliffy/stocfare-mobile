import 'dart:convert';
import 'dart:async';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/user_model.dart';

class AuthServices {
  Future<String> getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }

  Future<dynamic> userRegistration(
    String firstName,
    String lastName,
    String phone,
    String password,
    String email,
    String registrationId,
    String businessName,
    String businessAddress,
    String businessDescription,
    String businessType,
    String referralCode,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
      print(responseJson);
      sharedPreferences.setString("token", responseJson['token']['access']);
      dynamic user = User.fromJson(json.decode(response.body));
      sharedPreferences.setString("branchId", user.branchId);
      sharedPreferences.setString("body", response.body);
      sharedPreferences.setString('user_id', user.user_id);

      print(user.branchId);
      return user;
    } else {
      print(response.body);
      print(response.statusCode);
      return null;
    }
  }

  Future<dynamic> loginUsernew(
      String username, String password, String registrationid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final http.Response response = await http.post(
      'http://stockfare-io.herokuapp.com/api/v1/users/login/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
        "registration_id": registrationid
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
      print(user.firebaseId);
      return user;
    } else if (response.statusCode == 400) {
      print(response.body);
      return null;
    }
  }

  Future<dynamic> forgotPassword(String phone) async {
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
          "data": phone,
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
