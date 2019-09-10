// flutter
import 'dart:async';
import 'dart:convert';
// dependencies
import 'package:http/http.dart' as http;
// app
import 'package:game_scoreboard/env/env.dart';
import 'package:game_scoreboard/data/storedUser.dart';

/*
Service: API
*/
abstract class ApiServices {
  static String _apiRoot = env.apiRoot;
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

  static Uri _buildUri(
    String apiPath,
    {
      Map<String, dynamic> apiQuery
    }
  ) {
    Map<String, dynamic> body = new Map.from(_apiBaseBody);
    apiQuery == null ? null : body.addAll(apiQuery);

    Uri uri = Uri.parse(apiPath);
    uri = uri.replace(queryParameters: apiQuery);

    return uri;
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
      Map<String, dynamic> apiBody,
    }
  ) async {
    final String url = '$_apiRoot$apiEndpoint';
    final Map<String, String> headers = await _buildApiHeaders(apiHeaders: apiHeaders);
    final Uri uri = _buildUri(url, apiQuery: apiBody);

    return http.get(
      uri,
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
    final String url = '$_apiRoot$apiEndpoint';
    final Map<String, String> headers = await _buildApiHeaders(apiHeaders: apiHeaders);
    final Map<String, dynamic> body = _buildBody(apiBody: apiBody);

    return http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );
  }

  static Future<http.StreamedResponse> upload(
    String apiEndpoint,
    {
      Map<String, String> apiHeaders,
      Map<String, dynamic> apiFile,
      String apiRequest = 'POST',
    }
  ) async {
    final String url = '$_apiRoot$apiEndpoint';
    final Uri uri = _buildUri(url);
    final Map<String, String> headers = await _buildApiHeaders(apiHeaders: apiHeaders);
    final http.MultipartFile upload = await http.MultipartFile.fromPath(
      apiFile['param'] ?? 'upload',
      apiFile['file'].path
    );

    http.MultipartRequest request = http.MultipartRequest(apiRequest, uri);
    request.headers.addAll(headers);
    request.files.add(upload);

    return request.send();
  }

  static Future<http.Response> delete(
    String apiEndpoint,
    {
      Map<String, String> apiHeaders,
      Map<String, dynamic> apiBody,
    }
  ) async {
    final String url = '$_apiRoot$apiEndpoint';
    final Map<String, String> headers = await _buildApiHeaders(apiHeaders: apiHeaders);
    final Uri uri = _buildUri(url, apiQuery: apiBody);

    return http.delete(
      uri,
      headers: headers,
    );
  }
}
