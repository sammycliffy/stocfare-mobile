import 'package:flutter/foundation.dart';

class SignupNotifier with ChangeNotifier {
  String _firstName;
  String _fullName;
  String _lastName;
  String _phone;
  String _password;
  String _email;
  String _businessName;
  String _businessAddress;
  String _businessDescription;
  String _businessType;
  String _referralCode;

  String get firstName => _firstName;
  String get fullName => _fullName;
  String get lastName => _lastName;
  String get phone => _phone;
  String get password => _password;
  String get email => _email;
  String get businessName => _businessName;
  String get businessAddress => _businessAddress;
  String get businessDescription => _businessDescription;
  String get businessType => _businessType;
  String get referralCode => _referralCode;

  void setFirstPage(
    String firstName,
    String lastName,
    String phone,
    String password,
    String email,
  ) {
    _firstName = firstName;
    _lastName = lastName;
    _phone = phone;
    _password = password;
    _email = email;
    notifyListeners();
  }

  void setProfile(
    String fullName,
    String phone,
    String email,
  ) {
    _fullName = fullName;
    _phone = phone;
    _email = email;
    notifyListeners();
  }
}
