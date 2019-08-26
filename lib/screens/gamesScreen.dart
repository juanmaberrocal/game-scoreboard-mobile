// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/widgets/gameCard.dart';

/*
Screen: Games Dashboard
*/
class GamesScreen extends StatefulWidget {
  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GamesLibrary>(
      builder: (context, gamesLibrary, child) {
        final List<Widget> gameCards = gamesLibrary.games.map(
          (game) => GameCard(context, game)
        ).toList();

        return GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 10.0,
          crossAxisCount: 2,
          children: gameCards,
        );
      },
    );
  }
}
