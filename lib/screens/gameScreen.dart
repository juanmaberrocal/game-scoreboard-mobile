// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/models/game.dart';

/*
Screen: Game
*/
class GameScreen extends StatelessWidget {
  final Game game;

  GameScreen({this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: Center(
        child: Text(game.description),
      ),
    );
  }
}
