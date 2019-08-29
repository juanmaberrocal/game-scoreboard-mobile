// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/appProviders/playersLibrary.dart';
import 'package:game_scoreboard/widgets/playerCard.dart';

/*
Screen: Players Dashboard
*/
class PlayersScreen extends StatefulWidget {
  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayersLibrary>(
      builder: (context, playersLibrary, child) {
        final List<Widget> playerCards = playersLibrary.players.map(
          (player) => PlayerCard(context, player)
        ).toList();

        return RefreshIndicator(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            primary: false,
            padding: const EdgeInsets.all(20.0),
            children: playerCards,
          ),
          onRefresh: () {
            return Provider.of<PlayersLibrary>(context, listen: false).load();
          }
        );
      },
    );
  }
}
