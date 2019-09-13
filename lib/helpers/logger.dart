// flutter
// dependencies
import 'package:flutter_rollbar/flutter_rollbar.dart';
// app
import 'package:game_scoreboard/env/env.dart';

Logger get logger => Logger();

/*
Singleton: Logger
Handle all SharedPreference logic to
  get/set/clear stored data
*/
class Logger {
  /// Singleton definition
  static final Logger _singleton = Logger._internal();
  factory Logger() => _singleton;
  Logger._internal() {
    _rollBar = Rollbar()
      ..accessToken = env.rollbarToken
      ..environment = env.environment.toString().split('.').last;
  }

  /// Singleton members
  Rollbar _rollBar;

  Future<void> error(dynamic error, dynamic stackTrace) async {
    // Print the exception to the console.
    print('Caught error: $error');

    if (env.debug) {
      // Print the full stacktrace in debug mode.
      print(stackTrace);
      return;
    } else {
      // Send the Exception and Stacktrace to Rollbar in Production mode.
      _rollBar.addTelemetry(
        RollbarTelemetry(
          level: RollbarLogLevel.ERROR,
          type: RollbarTelemetryType.ERROR,
          message: error.toString(),
          stack: stackTrace.toString(),
        ),
      );

      _rollBar.publishReport(message: error.toString());
    }
  }
}
