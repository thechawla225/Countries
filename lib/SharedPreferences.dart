import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences _prefs;

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future setApiCall() async {
    await _prefs.setBool('called', true);
  }

  static bool getApiCall() => _prefs.getBool('called');
}
