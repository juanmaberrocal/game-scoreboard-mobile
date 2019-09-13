// flutter
import 'dart:async';
// dependencies
import 'package:shared_preferences/shared_preferences.dart';
// app

StoredUser get storedUser => StoredUser();

/*
Singleton: StoredUser
Handle all SharedPreference logic to
  get/set/clear stored data
 */
class StoredUser {
  /// Singleton definition
  static final StoredUser _singleton = StoredUser._internal();
  factory StoredUser() => _singleton;
  StoredUser._internal();

  /// Singleton members
  final String _authToken = 'auth_token';

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