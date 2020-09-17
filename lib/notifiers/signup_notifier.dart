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
  String get firebaseId => _firebaseId;
  String get branchName => _branchName;
  String get branchAddress => _branchAddress;
  bool get notificationStatus => _notificationStatus;
  String get subscriptionPlan => _subscriptionPlan;

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
      String subscriptionPlan) {
    _fullName = fullName;
    _phone = phone;
    _email = email;
    _firebaseId = firebaseId;
    _branchName = branchName;
    _branchAddress = branchAddress;
    _notificationStatus = notificationStatus;
    _subscriptionPlan = subscriptionPlan;
    notifyListeners();
  }
}
