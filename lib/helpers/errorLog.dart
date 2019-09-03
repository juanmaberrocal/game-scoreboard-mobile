// flutter
// dependencies
import 'package:flutter_rollbar/flutter_rollbar.dart';
// app
import 'package:game_scoreboard/env/env.dart';

Rollbar rollBar = Rollbar()
    ..accessToken = env.rollbarToken
    ..environment = env.environment.toString().split('.').last;

bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}

Future<void> reportError(dynamic error, dynamic stackTrace) async {
  // Print the exception to the console.
  print('Caught error: $error');

  if (isInDebugMode) {
    // Print the full stacktrace in debug mode.
    print(stackTrace);
    return;
  } else {
    // Send the Exception and Stacktrace to Rollbar in Production mode.
    rollBar.addTelemetry(
        RollbarTelemetry(
            level: RollbarLogLevel.ERROR,
            type: RollbarTelemetryType.ERROR,
            message: error.toString(),
            stack: stackTrace.toString(),
        ),
    );

    rollBar.publishReport(message: error.toString());
  }
}
