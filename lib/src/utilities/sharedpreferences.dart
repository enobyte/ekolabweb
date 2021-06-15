import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String user = 'user';

  static Future<bool> clearPreference(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(key);
    return preferences.remove(key);
  }

  static Future<bool> clearAllPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.clear();
  }

  static Future<bool> checkKey(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.containsKey(key);
  }

  /*
  Store String Data Value
   */
  static Future<bool> setStringPref(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future<String> getStringPref(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  /*
  Store Boolean Data Value
   */
  static Future<bool> setBoolPref(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future<bool?> getBoolPref(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  /*
  Store Int Data Value
   */

  static Future<bool> setIntPref(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  static Future<int?> getIntPref(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key);
  }

  /*
  Store List Data Value
   */

  static Future<bool> setListPref(String key, List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setStringList(key, value);
  }

  static Future<List<String>?> getListPref(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key);
  }
}
