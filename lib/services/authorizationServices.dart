// flutter
import 'dart:convert';
// dependencies
// app
import 'package:game_scoreboard/services/apiServices.dart';

/*
Service: Authorization
*/
abstract class AuthorizationServices {
  static Future<Map<String, dynamic>> logIn(String email, String password) async {
    final String apiUrl = 'login';
    final Map<String, dynamic> apiBody = {
      'player': {
        'email': email,
        'password': password,
      },
    };

    // post login request
    final response = await ApiServices.post(
      apiUrl,
      apiBody: apiBody
    );

    // parse json response
    final Map<String, dynamic> body = json.decode(response.body);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      final Map<String, String> headers = response.headers;
      final String token = headers['authorization'].split(" ").last;

      return {
        'token': token,
        'body': body
      };
    } else {
      // If that response was not OK, throw an error.
      throw Exception(body['error']);
    }
  }

  static Future<void> logOut() async {
    final String apiUrl = 'logout';

    // post logout request
    final response = await ApiServices.delete(
      apiUrl,
    );
    
    if (response.statusCode == 204) {
      // If server returns an OK response, parse the JSON.
      return null;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('eror');
    }
  }
}
