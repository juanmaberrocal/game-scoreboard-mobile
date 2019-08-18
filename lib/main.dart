import 'package:flutter/material.dart';

import 'package:game_scoreboard/screens/splashScreen.dart';
import 'package:game_scoreboard/screens/loginScreen.dart';
import 'package:game_scoreboard/screens/dashboardScreen.dart';

void main() => runApp(GameScoreboard());

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
        '/dashboard': (context) => DashboardScreen()
      },
      home: SplashScreen(),
    );
  }
}
