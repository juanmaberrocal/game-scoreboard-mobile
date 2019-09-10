// flutter
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// dependencies
// app
import 'package:game_scoreboard/env/env.dart';
import 'package:game_scoreboard/helpers/errorLog.dart';
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/appProviders/playersLibrary.dart';
import 'package:game_scoreboard/screens/splashScreen.dart';
import 'package:game_scoreboard/screens/loginScreen.dart';
import 'package:game_scoreboard/screens/dashboardScreen.dart';
import 'package:game_scoreboard/screens/profileScreen.dart';
import 'package:game_scoreboard/screens/profileEditScreen.dart';

Future<Null> main() async {
  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Rollbar.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  // This creates a [Zone] that contains the Flutter application and stablishes
  // an error handler that captures errors and reports them.
  //
  // Using a zone makes sure that as many errors as possible are captured,
  // including those thrown from [Timer]s, microtasks, I/O, and those forwarded
  // from the `FlutterError` handler.
  runZoned<Future<Null>>(() async {
    BuildFlavor buildFlavor = isInDebugMode ? BuildFlavor.development : BuildFlavor.production;
    await BuildEnvironment.init( // ignore: await_only_futures
        flavor: buildFlavor
    );

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CurrentPlayer>(builder: (context) => CurrentPlayer()),
          ChangeNotifierProvider<GamesLibrary>(builder: (context) => GamesLibrary()),
          ChangeNotifierProvider<PlayersLibrary>(builder: (context) => PlayersLibrary()),
        ],
        child: GameScoreboard(),
      ),
    );
  }, onError: (error, stackTrace) async {
    await reportError(error, stackTrace);
  });
}

class GameScoreboard extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Scoreboard',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/profile': (context) => ProfileScreen(),
        '/profile/edit': (context) => ProfileEditScreen(),
      },
      home: SplashScreen(),
    );
  }
}
