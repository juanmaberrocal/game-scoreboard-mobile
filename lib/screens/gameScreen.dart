// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// dependencies
// app
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/screens/gameEditScreen.dart';
import 'package:game_scoreboard/widgets/appBlocks.dart';
import 'package:game_scoreboard/widgets/avatarUpload.dart';
import 'package:game_scoreboard/widgets/circleLoader.dart';
import 'package:game_scoreboard/widgets/errorDisplay.dart';
import 'package:game_scoreboard/widgets/gameAvatar.dart';
import 'package:game_scoreboard/widgets/standingList.dart';

/*
Screen: Game
*/
class GameScreen extends StatefulWidget {
  GameScreen({
    Key key,
    this.gameId,
    this.gameName
  }) : super(key: key);

  final int gameId;
  final String gameName;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Profile scaffold identifier key
  final GlobalKey<ScaffoldState> _gameScaffoldKey = GlobalKey<ScaffoldState>();

  // loaders
  Future<Game> _game;
  Future<List> _standings;

  Future<void> _changeAvatar(Game game) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AvatarUpload(
          uploadFunction: Game(id: widget.gameId).upload,
          screenContext: context,
          screenScaffold: _gameScaffoldKey,
        );
      },
    );
  }

  void _goToGameEdit(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameEditScreen(
          game: game,
          successCallback: (Game _updatedGame) {
            _game = Game.fetch(_updatedGame.id).then((Game game) {
              _standings = game.standings();
              return game;
            });

            Provider.of<GamesLibrary>(context, listen: false).load();
          },
        ),
      ),
    );
  }

  void _deleteGame(Game game) {
    print("in delete");
  }

  @override
  void initState() {
    _game = Game.fetch(widget.gameId).then((Game game) {
      _standings = game.standings();
      return game;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text(widget.gameName),
    );

    return FutureBuilder<Game>(
      future: _game,
      builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
        if (snapshot.hasData) {
          final Game game = snapshot.data;

          return AppScaffold(
            key: _gameScaffoldKey,
            top: appBar,
            bottom: Provider.of<CurrentPlayer>(context, listen: false).isAdmin() ? AppEditBar(
              record: game,
              avatarCallback: _changeAvatar,
              editCallback: _goToGameEdit,
              deleteCallback: _deleteGame,
            ) : null,
            center: ListView(
              children: <Widget>[
                _GameBody(game: game),
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
                  },
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return AppScaffold(
            key: _gameScaffoldKey,
            top: appBar,
            center: ErrorDisplay(
              errorMessage: 'Could not load game data',
            ),
          );
        }

        return AppScaffold(
          key: _gameScaffoldKey,
          top: appBar,
          center: CircleLoader(),
        );
      },
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
          GameAvatar(
            game: game,
            height: MediaQuery.of(context).size.height / 4.0,
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
