// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/helpers/colorSelector.dart';
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/screens/gameScreen.dart';

/*
Widget: GameCard
*/
Card GameCard(BuildContext context, Game game) {
  return Card(
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(
              gameId: game.id,
              gameName: game.name,
            )
          ),
        );
      },
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 30,
              backgroundColor: getColorFromString(game.name),
              child: Text(
                game.name[0],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.bottomCenter,
              child: FittedBox(
                child: Text(
                  game.name,
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ]
      ),
    ),
  );
}
