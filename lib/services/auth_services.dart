import 'dart:convert';
import 'dart:async';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<String> getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }

  Future<dynamic> userRegistration(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
    String registrationId,
    String businessName,
    String businessAddress,
    String businessDescription,
    String businessType,
    String referralCode,
  ) async {
    final String url =
        'http://stockfare-io.herokuapp.com/api/v2/users/register/';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "phone_number": phone,
          "password": password,
          "registration_id": registrationId,
          "name": businessName,
          "address": businessAddress,
          "description": businessDescription,
          "referral": referralCode,
          "business_type": businessType
        }));

    print(response.body);

    return response.body;
  }
}
