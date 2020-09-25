import 'package:shared_preferences/shared_preferences.dart';

class DateHelper {
  checkDate() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String subPlan = _sharedPreferences.getString('date');
    return subPlan;
  }
}
