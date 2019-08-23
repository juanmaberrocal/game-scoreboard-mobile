// flutter
import 'dart:async';
import 'dart:convert';
// dependencies
import 'package:http/http.dart' as http;
// app
import 'package:game_scoreboard/data/storedUser.dart';

/*
Service: API
*/
abstract class ApiServices {
  static String _apiRoot = 'http://localhost:3000/';
  static Map<String, String> _apiBaseHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };
  static Map<String, dynamic> _apiBaseBody = {};

  static Future<Map<String, String>> _buildApiHeaders({
    Map<String, String> apiHeaders
  }) async {
    Map<String, String> headers = new Map.from(_apiBaseHeaders);
    String authToken = await StoredUser.getToken();
    authToken == null ? null : headers.addAll({'Authorization': 'Bearer $authToken'});
    apiHeaders == null ? null : headers.addAll(apiHeaders);
    return headers;
  }

  static Map<String, dynamic> _buildBody({
    Map<String, dynamic> apiBody
  }) {
    Map<String, dynamic> body = new Map.from(_apiBaseBody);
    apiBody == null ? null : body.addAll(apiBody);
    return body;
  }

  static Future<http.Response> get(
    String apiEndpoint,
    {
      Map<String, String> apiHeaders,
    }
  ) async {
    String url = '${_apiRoot}${apiEndpoint}';
    Map<String, String> headers = await _buildApiHeaders(apiHeaders: apiHeaders);

    return http.get(
      url,
      headers: headers,
    );
  }

  static Future<http.Response> post(
    String apiEndpoint,
    {
      Map<String, String> apiHeaders,
      Map<String, dynamic> apiBody,
    }
  ) async {
    String url = '${_apiRoot}${apiEndpoint}';
    Map<String, String> headers = await _buildApiHeaders(apiHeaders: apiHeaders);
    Map<String, dynamic> body = _buildBody(apiBody: apiBody);

    return http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );
  }

  static Future<http.Response> delete(
    String apiEndpoint,
    {
      Map<String, String> apiHeaders,
    }
  ) async {
    String url = '${_apiRoot}${apiEndpoint}';
    Map<String, String> headers = await _buildApiHeaders(apiHeaders: apiHeaders);

    return http.delete(
      url,
      headers: headers,
    );
  }
}