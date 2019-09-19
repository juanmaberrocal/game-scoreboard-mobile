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
            Body(),
            Footer(),
          ]
        ),
      ),
    );
  }
}

/*
Widget: Body
Builds splash body layout with the app logo and title in the center
  (expected to take up most available space)
 */
class Body extends StatelessWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(top: 15.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Game Scoreboard",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
Widget: Footer
Display a small footer text
  (does not contain any logic about where it should be placed)
 */
class Footer extends StatelessWidget {
  Footer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        height: 10,
        width: double.infinity,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            "Developed by Saludzinho™",
            style: TextStyle(fontSize: 8.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
