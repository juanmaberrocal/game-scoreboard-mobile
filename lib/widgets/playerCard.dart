// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/helpers/colorSelector.dart';
import 'package:game_scoreboard/models/player.dart';

/*
Widget: PlayerCard
Builds a ListTile displaying:

Player player: [required]
 */

class PlayerCard extends StatelessWidget {
  PlayerCard({
    Key key,
    @required this.player
  }) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50.0),
          width: double.infinity,
          child: Card(
            child: Container(
              margin: EdgeInsets.only(top: 50.0),
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "${player.firstName} ${player.lastName}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(player.email),
                ],
              ),
            ),
          ),
        ),
        CircleAvatar(
          minRadius: 50,
          backgroundColor: getColorFromString(player.nickname),
          child: Text("${player.firstName[0]}${player.lastName[0]}"),
        ),
      ],
    );
  }
}