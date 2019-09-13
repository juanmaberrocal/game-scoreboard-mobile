// flutter
import 'dart:async';
// dependencies
import 'package:shared_preferences/shared_preferences.dart';
// app

StoredUser get storedUser => _storedUser;
StoredUser _storedUser;

/*
Singleton: StoredUser
Handle all SharedPreference logic to
  get/set/clear stored data
*/
class StoredUser {
  final String _authToken = 'auth_token';

  /// Sets up the top-level [storedUser] getter on the first call only.
  static Future<void> init() async {
    _storedUser ??= StoredUser._init();
  }

  StoredUser();

  factory StoredUser._init() => StoredUser();

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authToken) ?? null;
  }

  Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authToken, token);
  }

  Future<void> clear() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
  }
}
