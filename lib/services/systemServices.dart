// flutter
import 'dart:convert';
// dependencies
// app
import 'package:game_scoreboard/services/apiServices.dart';

abstract class SystemServices {
  static Future<bool> ping() async {
    final String apiUrl = 'ping';

    // send ping request
    final response = await ApiServices.get(
      apiUrl,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('API Failed to Respond');
    }
  }
}


