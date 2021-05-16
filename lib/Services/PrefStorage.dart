import 'package:shared_preferences/shared_preferences.dart';

class PrefStorage {
  static SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future storeUserInfo(String key, String value) async {
    await _prefs.setString(key, value);
  }

  getUserInfo(String key) {
    return _prefs.getString(key);
  }

  Future deleteUserInfo(String email, String name) async {
    _prefs.remove(email);
    _prefs.remove(name);
  }

  Future<bool> isLoggedIn() async {
    if (_prefs.getString("email") != null && _prefs.getString("name") != null) {
      return true;
    } else {
      return false;
    }
  }
}
