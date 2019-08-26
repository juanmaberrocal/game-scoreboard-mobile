// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/widgets/errorDisplay.dart';

/*
Screen: Profile
*/
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Player player;

  @override
  void initState() {
    player = Provider.of<CurrentPlayer>(context, listen: false).player;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.nickname),
      ),
      body: Text("foo"),
    );
  }
}
