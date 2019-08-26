// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/widgets/errorDisplay.dart';

/*
Screen: Game
*/
class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.gameId, this.gameName}) : super(key: key);

  final int gameId;
  final String gameName;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Future<Game> _game;

  @override
  void initState() {
    _game = Game(id: widget.gameId).fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameName),
      ),
      body: FutureBuilder<Game>(
        future: _game,
        builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
          if (snapshot.hasData) {
            final Game game = snapshot.data;

            return Center(
              child: Text(game.description),
            );
          } else if (snapshot.hasError) {
            return ErrorDisplay(context, "There was an error loading the game");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        }
      ),
    );
  }
}
