// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/models/player.dart';

/*
Screen: Player
*/
class PlayerScreen extends StatelessWidget {
  final Player player;

  PlayerScreen({this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.nickname),
      ),
      body: Center(
        child: Text(player.firstName),
      ),
    );
  }
}
