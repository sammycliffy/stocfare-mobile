import 'package:shared_preferences/shared_preferences.dart';

class Subscription {
  void setPlanToFree() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString('subscription_plan', 'FREE');
  }

  setPlanToPremium() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString('subscription_plan', 'PREMIUM');
  }

  Future<String> getSubscriptionPlan() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String subPlan = _sharedPreferences.getString('subscription_plan');
    return subPlan;
  }
}
