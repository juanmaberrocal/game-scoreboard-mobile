// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/helpers/colorSelector.dart';
import 'package:game_scoreboard/models/game.dart';

Card GameCard(BuildContext context, Game game) {
  final Widget cardIcon = Center(
    child: Container(
      child: Center(
        child: Text(
          game.name[0].toUpperCase(),
          style: DefaultTextStyle.of(context).style.apply(
            fontSizeFactor: 3.7,
            color: Colors.white,
          ),
        ),
      ),
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: getColorFromString(game.name),
      ),
    ),
  );
  final Widget cardTitle = Text(
    game.name,
    style: DefaultTextStyle.of(context).style.apply(
      fontSizeFactor: 1.2
    ),
  );

  return Card(
    child: Column(
      children: [
        Expanded(
          child: cardIcon,
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: cardTitle,
        ),
      ]
    ),
  );
}
