import 'dart:convert';

import 'package:medify/features/authentication/register/data/models/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static late final SharedPreferences _sharedPreferences;

  static const String authResponseKey = 'authResponse';
  static const String isLoggedInKey = 'isLoggedIn';

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setAuthResponseModel(AuthResponseModel authResponseModel) async {
    final String jsonString = json.encode(authResponseModel.toJson());
    await _sharedPreferences.setString(authResponseKey, jsonString);
  }

  static AuthResponseModel? getAuthResponseModel() {
    final String? jsonString = _sharedPreferences.getString(authResponseKey);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return AuthResponseModel.fromJson(jsonMap);
    }
    return null;
  }

  static setIsLogin(bool isLoggedIn) async {
    await _sharedPreferences.setBool(isLoggedInKey, isLoggedIn);
  }

  static bool getIsLogin() {
    return _sharedPreferences.getBool(isLoggedInKey) ?? false;
  }
}
