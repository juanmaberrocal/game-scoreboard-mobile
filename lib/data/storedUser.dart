import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StoredUser {
  static String authToken = 'auth_token';

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authToken) ?? null;
  }

  static Future<String> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(authToken, token);
  }

  static Future<bool> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
