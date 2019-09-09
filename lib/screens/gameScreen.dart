// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/widgets/circleLoader.dart';
import 'package:game_scoreboard/widgets/errorDisplay.dart';
import 'package:game_scoreboard/widgets/standingList.dart';

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
    _game = Game().fetch(widget.gameId);
    _standings = Game().standings(widget.gameId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameName),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            FutureBuilder<Game>(
                future: _game,
                builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
                  if (snapshot.hasData) {
                    return _GameBody(game: snapshot.data);
                  } else if (snapshot.hasError) {
                    return ErrorDisplay(
                      errorMessage: 'Could not load game data',
                    );
                  }

                  return CircleLoader();
                }
            ),
            FutureBuilder(
                future: _standings,
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    final List<dynamic> standingsData = snapshot.data;

                    return StandingList(
                      standingsData: standingsData,
                    );
                  } else if (snapshot.hasError) {
                    return ErrorDisplay(
                      errorMessage: 'Could not load standings table',
                    );
                  }

                  // By default, show a loading spinner.
                  return CircleLoader();
                }
            ),
          ],
        ),
      )
    );
  }
}

class _GameBody extends StatelessWidget {
  _GameBody({
    Key key,
    @required this.game
  }) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: false ? NetworkImage(
                    "https://cf.geekdo-images.com/itemrep/img/aozRplCSOpRucLxSuClX2odEUBQ=/fit-in/246x300/pic2419375.jpg"
                ) : AssetImage('assets/images/Missing-image-232x150.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
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
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Text(game.description),
          ),
        ],
      ),
    );
  }
}
