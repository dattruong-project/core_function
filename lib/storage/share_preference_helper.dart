import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  SharedPreferencesHelper._();
  static SharedPreferencesHelper get instance => SharedPreferencesHelper._();

  static late SharedPreferences _pref;

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  void setString(String key, String value) => _pref.setString(key, value);

  void setInt(String key, int value) => _pref.setInt(key, value);

  void setDouble(String key, double value) => _pref.setDouble(key, value);

  void setBool(String key, bool value) => _pref.setBool(key, value);

  Future<bool> setObject({
    required SharedPreferencesRequest<Map<String, dynamic>> request,
  }) async {
    final data = await _pref.setString(request.key, jsonEncode(request.value));
    return data;
  }

  String? getString(String key) => _pref.getString(key);

  int? getInt(String key) => _pref.getInt(key);

  double? getDouble(String key) => _pref.getDouble(key);

  bool? getBool(String key) => _pref.getBool(key);

  Map<String, dynamic> getObject({
    required String key,
  }) {
    final object = _pref.getString(key);
    if (object == null || object.isEmpty) {
      return {};
    }
    return jsonDecode(object) as Map<String, dynamic>;
  }

  Future<void> cleanAllData() {
    return _pref.clear();
  }

}

class SharedPreferencesRequest<T> {
  SharedPreferencesRequest({required this.key, required this.value});
  final String key;
  final T value;
}