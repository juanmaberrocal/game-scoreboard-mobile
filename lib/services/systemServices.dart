import 'package:http/http.dart' as http;

abstract class SystemServices {
  static String apiRoot = 'http://localhost:3000/';
  static String apiV1Root = '${apiRoot}v1/';
  static String apiV2Root = '${apiRoot}v2/';

  static Future<bool> ping() async {
    final response = await http.get('${apiRoot}ping');

    if (response.statusCode == 200) {
      return true;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('API Failed to Respond');
    }
  }
}


