// flutter
import 'dart:async';
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/appProviders/playersLibrary.dart';

Future<void> _logoutConfirmDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Log Out?'),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              Provider.of<CurrentPlayer>(context, listen: false).logOut().then((void _) {
                Provider.of<PlayersLibrary>(context, listen: false).clear();
                Provider.of<GamesLibrary>(context, listen: false).clear();

                // if sign out successful navigate to login
                Navigator.of(context).pushReplacementNamed('/login');
              }).catchError((err) {
                // if sign out failed
                Navigator.of(context).pushReplacementNamed('/login');
              });
            },
          )
        ],
      );
    },
  );
}

MainAppBar(context, TabController _tabController) {
  IconButton _logOutButton() {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      tooltip: 'Log Out',
      onPressed: () async {
        await _logoutConfirmDialog(context);
      },
    );
  }

  IconButton _profileButton() {
    return IconButton(
      icon: const Icon(Icons.face),
      // icon: const Icon(Icons.account_box),
      tooltip: 'Profile',
      onPressed: () {
        Navigator.of(context).pushNamed('/profile');
      },
    );
  }

  return AppBar(
    title: const Text("Game Scoreboard"),
    actions: <Widget>[
      _profileButton(),
      _logOutButton(),
    ],
    bottom: TabBar(
      controller: _tabController,
      tabs: <Widget>[
        Tab(icon: Icon(Icons.games)),
        Tab(icon: Icon(Icons.home)),
        Tab(icon: Icon(Icons.people)),
      ],
    ),
  );
}
