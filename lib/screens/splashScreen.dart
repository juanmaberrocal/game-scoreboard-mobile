//flutter
import 'dart:async';
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/appProviders/playersLibrary.dart';
import 'package:game_scoreboard/services/systemServices.dart';

/*
Screen: Splash
*/
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int retryDuration = 2;
  final int retryLimit = 5;
  int retryCount = 0;

  void _loadApi() {
    // ensure api is awake
    SystemServices.ping().then((resp) {
      // check if user has already logged in
      // and redirect to login or dashboard
      Provider.of<CurrentPlayer>(context, listen: false).renew().then((bool isLoggedIn) {
        final String redirectPath = isLoggedIn ? '/dashboard' : '/login';
        
        if (isLoggedIn) {
          Provider.of<GamesLibrary>(context, listen: false).load().then((_) {
            Provider.of<PlayersLibrary>(context, listen: false).load().then((_) {
              Navigator.of(context).pushReplacementNamed(redirectPath);
            });
          });
        } else {
          Navigator.of(context).pushReplacementNamed(redirectPath);
        }
      });
    }).catchError((err) {
      // if api is not awake
      // retry ping {retryLimit} amount of times
      retryCount++;

      if (retryCount < retryLimit) {
        Timer(
          Duration(seconds: retryDuration),
          () { _loadApi(); }
        );
      } else {
        // if ping response never returns raise error
        throw Exception('API Failed to Respond');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/game-die_1f3b2.png"),
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: Text("Game Scoreboard", style: TextStyle(fontSize: 40.0, color: Colors.white),),
                  ),
                ]
              )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
              child: Text("Developed by Juanma", style: TextStyle(fontSize: 16.0, color: Colors.white),),
            ),
          ]
        )
      )
    );
  }
}
