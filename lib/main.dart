// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// dependencies
// app
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/appProviders/playersLibrary.dart';
import 'package:game_scoreboard/screens/splashScreen.dart';
import 'package:game_scoreboard/screens/loginScreen.dart';
import 'package:game_scoreboard/screens/dashboardScreen.dart';
import 'package:game_scoreboard/screens/profileScreen.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<CurrentPlayer>(builder: (context) => CurrentPlayer()),
      ChangeNotifierProvider<GamesLibrary>(builder: (context) => GamesLibrary()),
      ChangeNotifierProvider<PlayersLibrary>(builder: (context) => PlayersLibrary()),
    ],
    child: GameScoreboard(),
  ),
);

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
      },
      home: SplashScreen(),
    );
  }
}
