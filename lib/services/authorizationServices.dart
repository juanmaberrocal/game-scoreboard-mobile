import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:game_scoreboard/models/currentPlayer.dart';

abstract class AuthorizationServices {
  static String apiRoot = 'http://localhost:3000/';

  static Future<CurrentPlayer> logIn(String email, String password) async {
    final String apiLogin = '${apiRoot}login';
    final Map<String, String> apiHeaders = { 'Accept': 'application/json', 'Content-Type': 'application/json' };
    final String apiBody = json.encode({
      'player': {
        'email': email,
        'password': password,
      },
    });

    final response = await http.post(
      apiLogin,
      headers: apiHeaders,
      body: apiBody,
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      final Map<String, String> headers = response.headers;
      final String authToken = headers['authorization'].split(" ").last;

      final Map<String, dynamic> jsonBody = json.decode(response.body);

      return CurrentPlayer.fromJson(jsonBody, authToken);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Could Not Sign In Player');
    }
  }

  static void logOut() async {
    
  }
}
