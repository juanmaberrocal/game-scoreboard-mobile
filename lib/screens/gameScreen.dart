// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/widgets/standingsList.dart';
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
  Future<List> _standings;

  @override
  void initState() {
    _game = Game(id: widget.gameId).fetch();
    _standings = Game().standings(widget.gameId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameName),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<Game>(
              future: _game,
              builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
                if (snapshot.hasData) {
                  final Game game = snapshot.data;

                  return Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: double.infinity,
                        margin: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Missing-image-232x150.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(game.description),
                      Container(
                        margin: EdgeInsets.all(30),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.group),
                                  Text("${game.minPlayers.toString()} - ${game.maxPlayers.toString()}"),
                                ],
                              ),
                            ),
                            VerticalDivider(),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.timer),
                                  Text("${game.minPlayTime.toString()} - ${game.maxPlayTime.toString()}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return ErrorDisplay(context, "There was an error loading the game");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
            Divider(),
            Text("Standings:"),
            FutureBuilder<List>(
              future: _standings,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  final List standings = snapshot.data;
                  return StandingsList(context, standings);
                } else if (snapshot.hasError) {
                  return ErrorDisplay(context, "There was an error loading the standings");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
