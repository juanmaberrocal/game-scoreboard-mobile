// flutter
import 'dart:convert';
// dependencies
import 'package:http/http.dart' as http;
// app

/*
Service: Authorization
*/
abstract class AuthorizationServices {
  static String apiRoot = 'http://localhost:3000/';

  static Future<Map<String, dynamic>> logIn(String email, String password) async {
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
    final String apiLogout = '${apiRoot}logout';
    final Map<String, String> apiHeaders = { 'Accept': 'application/json', 'Content-Type': 'application/json' };
    
    final response = await http.delete(
      apiLogout,
      headers: apiHeaders,
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
