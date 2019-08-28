// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/helpers/colorSelector.dart';
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/screens/playerScreen.dart';

/*
Widget: PlayerCard
*/
Card PlayerCard(BuildContext context, Player player) {
  final Widget card = ListTile(
    leading: Icon(Icons.person),
    title: Text(player.nickname),
  );

  return Card(
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerScreen(
              playerId: player.id,
              playerNickname: player.nickname,
            )
          ),
        );
      },
      child: card,
    ),
  );
}
