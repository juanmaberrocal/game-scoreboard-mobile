// flutter
import 'dart:convert';
// dependencies
// app
import 'package:game_scoreboard/services/apiServices.dart';

/*
Service: Authorization
*/
abstract class AuthorizationServices {
  static Map<String, dynamic> _tokenBodyResponse(response) {
    final Map<String, dynamic> body = json.decode(response.body);
    final Map<String, String> headers = response.headers;
    final String token = headers['authorization'].split(" ").last;

    return {
      'token': token,
      'body': body
    };
  }

  static Future<Map<String, dynamic>> renewToken() async {
    final String apiUrl = 'renew';
    
    // post renew request
    final response = await api.get(
      apiUrl,
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return _tokenBodyResponse(response);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Oops, something went wrong');
    }
  }

  static Future<Map<String, dynamic>> changePassword(
    String currentPassword,
    String password,
    String passwordConfirmation
  ) async {
    final String apiUrl = 'update_password';
    final Map<String, dynamic> apiBody = {
      'player': {
        'current_password': currentPassword,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    };

    // post password update request
    final response = await api.post(
      apiUrl,
      apiBody: apiBody,
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return _tokenBodyResponse(response);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Oops, something went wrong');
    }
  }

  static Future<Map<String, dynamic>> logIn(
    String email,
    String password
  ) async {
    final String apiUrl = 'login';
    final Map<String, dynamic> apiBody = {
      'player': {
        'email': email,
        'password': password,
      },
    };

    // post login request
    final response = await api.post(
      apiUrl,
      apiBody: apiBody
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return _tokenBodyResponse(response);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Invalid Username or Password');
    }
  }

  static Future<void> logOut() async {
    final String apiUrl = 'logout';

    // post logout request
    final response = await api.delete(
      apiUrl,
    );
    
    if (response.statusCode == 204) {
      // If server returns an OK response, parse the JSON.
      return null;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Oops, something went wrong');
    }
  }
}
