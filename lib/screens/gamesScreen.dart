// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/helpers/colorSelector.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/screens/gameScreen.dart';

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
          (game) => _GameGridElement(game: game)
        ).toList();

        return OrientationBuilder(
          builder: (context, orientation) {
            return RefreshIndicator(
              child: GridView.count(
                physics: const AlwaysScrollableScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.all(20.0),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 10.0,
                crossAxisCount: orientation == Orientation.portrait ? 3 : 5,
                children: gameCards,
              ),
              onRefresh: () {
                return Provider.of<GamesLibrary>(context, listen: false).load();
              }
            );
          },
        );
      },
    );
  }
}

class _GameGridElement extends StatelessWidget {
  _GameGridElement({
    Key key,
    this.game,
  }) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
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
}