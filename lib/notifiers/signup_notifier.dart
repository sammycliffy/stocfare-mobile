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
  String _firebaseId;
  String _branchName;
  String _branchAddress;
  bool _notificationStatus;
  String _subscriptionPlan;
  String _firebaseCustomerId;
  String _notificationId;
  String _country;
  String get firstName => _firstName;
  String get fullName => _fullName;
  String get lastName => _lastName;
  String get notificationId => _notificationId;
  String get phone => _phone;
  String get firebaseCustomerId => _firebaseCustomerId;
  String get password => _password;
  String get email => _email;
  String get businessName => _businessName;
  String get businessAddress => _businessAddress;
  String get businessDescription => _businessDescription;
  String get businessType => _businessType;
  String get referralCode => _referralCode;
  String get firebaseId => _firebaseId;
  String get branchName => _branchName;
  String get branchAddress => _branchAddress;
  bool get notificationStatus => _notificationStatus;
  String get subscriptionPlan => _subscriptionPlan;
  String get country => _country;

  //set values to be transferred to the business signup page
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

  //set profile values so that they can be called from anywhere
  void setProfile(
      String fullName,
      String phone,
      String email,
      String firebaseId,
      String branchName,
      String branchAddress,
      bool notifictionStatus,
      String subscriptionPlan,
      String firebaseCustomerId,
      String notificationId) {
    _fullName = fullName;
    _phone = phone;
    _email = email;
    _firebaseId = firebaseId;
    _branchName = branchName;
    _branchAddress = branchAddress;
    _notificationStatus = notificationStatus;
    _subscriptionPlan = subscriptionPlan;
    _firebaseCustomerId = firebaseCustomerId;
    _notificationId = notificationId;
    notifyListeners();
  }

  void setCountry(String country) {
    _country = country;
    notifyListeners();
  }
}
