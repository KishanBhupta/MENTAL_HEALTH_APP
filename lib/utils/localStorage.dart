import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static late SharedPreferences _preferences;

  // function to initialize the shared preferences instance
  Future<void> initializeLocalStorage() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool hasKey({required String key}) {
    return _preferences.containsKey(key);
  }

  // function to get string values
  String? getStringValue({required String key}) {
    return _preferences.getString(key);
  }
  // function to get bool values
  bool? getBoolValue({required String key}){
    return _preferences.getBool(key);
  }

  // function to set string values
  Future<void> setStringValue({required String key,required String value}) async {
    await _preferences.setString(key, value);
  }

  // function to set bool values
  Future<void> setBoolValue({required String key,required bool value}) async {
    await _preferences.setBool(key, value);
  }

}