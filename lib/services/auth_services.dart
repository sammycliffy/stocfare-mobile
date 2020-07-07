import 'dart:convert';
import 'dart:async';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/user_model.dart';
import 'package:connectivity/connectivity.dart';

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
      sharedPreferences.setString("token", responseJson['token']['access']);
      print(responseJson);
      //sharedPreferences.setString("token", responseJson['token']['access']);
      dynamic user = User.fromJson(json.decode(response.body)['user']);
      print(user.branchId);
      sharedPreferences.setString("branchId", user.branchId);
      print(user.branch.id);
      return user;
    } else {
      print(response.body);
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
      print(user.branchId);
      return user;
    } else if (response.statusCode == 400) {
      print(response.body);
      return null;
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

  //check for internet
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
