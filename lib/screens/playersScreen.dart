// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/collections/players.dart';
import 'package:game_scoreboard/widgets/playerCard.dart';
import 'package:game_scoreboard/widgets/errorDisplay.dart';

/*
Screen: Players Dashboard
*/
class PlayersScreen extends StatefulWidget {
  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  Future<Players> _players;

  @override
  void initState() {
    _players = Players().fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Players>(
      future: _players,
      builder: (BuildContext context, AsyncSnapshot<Players> snapshot) {
        if (snapshot.hasData) {
          final Players players = snapshot.data;
          final List<Widget> playerCards = players.records.map(
            (player) => PlayerCard(context, player)
          ).toList();

          return ListView(
            primary: false,
            padding: const EdgeInsets.all(20.0),
            children: playerCards,
          );
        } else if (snapshot.hasError) {
          return ErrorDisplay(context, "There was an error loading the players");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
