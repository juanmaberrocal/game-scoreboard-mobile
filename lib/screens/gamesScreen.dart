// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/helpers/device.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/screens/gameScreen.dart';
import 'package:game_scoreboard/widgets/gameAvatar.dart';


/*
Screen: Games Dashboard
*/
class GamesScreen extends StatefulWidget {
  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  int _gridCount(MediaSize mediaSize) {
    int count;

    switch(mediaSize) {
      case MediaSize.xs: {
        count = 2;
        break;
      }

      case MediaSize.s: {
        count = 3;
        break;
      }

      case MediaSize.m:
      case MediaSize.l: {
        count = 5;
        break;
      }

      case MediaSize.xl: {
        count = 1;
        break;
      }
    }

    return count;
  }

  @override
  Widget build(BuildContext context) {
    final device = Device.get(context);

    return Consumer<GamesLibrary>(
      builder: (context, gamesLibrary, child) {
        final List<Widget> gameCards = gamesLibrary.games.map((game) => _GameGridElement(game: game)).toList();

        return RefreshIndicator(
          child: GridView.count(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(20.0),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            crossAxisCount: _gridCount(device.mediaSize),
            children: gameCards,
          ),
          onRefresh: () {
            return Provider.of<GamesLibrary>(context, listen: false).load();
          },
        );
      },
    );
  }
}

class _GameGridElement extends StatelessWidget {
  _GameGridElement({
    Key key,
    @required this.game,
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
              ),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: GameAvatar(game: game),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  game.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}