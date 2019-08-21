// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/currentPlayer.dart';

/*
Screen: Dashboard
*/
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Game Scoreboard"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Log Out',
            onPressed: () {
              Provider.of<CurrentPlayer>(context, listen: false).logOut().then((void _) {
                // if sign out successful navigate to login
                Navigator.of(context).pushReplacementNamed('/login');
              }).catchError((err) {
                // if sign out failed
                Navigator.of(context).pushReplacementNamed('/login');
              });
            },
          ),
        ],
      ),
      body: Center(
        // child: Text("Dashboard!"),
        child: Consumer<CurrentPlayer>(
          builder: (context, currentPlayer, child) {
            return Text('Total price: ${currentPlayer.player?.email}');
          },
        ),
      ),
    );
  }
}
