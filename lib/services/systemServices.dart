import 'package:http/http.dart' as http;

abstract class SystemServices {
  static String apiRoot = 'http://localhost:3000/';

  static Future<bool> ping() async {
    final apiPing = '${apiRoot}ping';
    final response = await http.get(apiPing);

    if (response.statusCode == 200) {
      return true;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('API Failed to Respond');
    }
  }
}


