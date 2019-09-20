// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// dependencies
// app
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/appProviders/playersLibrary.dart';
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/screens/playerEditScreen.dart';
import 'package:game_scoreboard/widgets/appBlocks.dart';
import 'package:game_scoreboard/widgets/circleLoader.dart';
import 'package:game_scoreboard/widgets/errorDisplay.dart';
import 'package:game_scoreboard/widgets/playerCard.dart';
import 'package:game_scoreboard/widgets/standingList.dart';

/*
Screen: Player
*/
class PlayerScreen extends StatefulWidget {
  PlayerScreen({
    Key key, this.playerId, this.playerNickname
  }) : super(key: key);

  final int playerId;
  final String playerNickname;

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  Future<Player> _player;
  Future<List> _standings;

  void _goToPlayerEdit(Player player) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerEditScreen(
          player: player,
          successCallback: (Player _updatedPlayer) {
            _player = Player.fetch(_updatedPlayer.id).then((Player player) {
              _standings = player.standings();
              return player;
            });

            Provider.of<PlayersLibrary>(context, listen: false).load();
          },
        ),
      ),
    );
  }

  void _deletePlayer(Player player) {
    print("in delete");
  }

  @override
  void initState() {
    _player = Player.fetch(widget.playerId).then((Player player) {
      _standings = player.standings();
      return player;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text(widget.playerNickname),
    );

    return FutureBuilder<Player>(
      future: _player,
      builder: (BuildContext context, AsyncSnapshot<Player> snapshot) {
        if (snapshot.hasData) {
          final Player player = snapshot.data;

          return AppScaffold(
            top: appBar,
            bottom: Provider.of<CurrentPlayer>(context, listen: false).isAdmin() ? AppEditBar(
              record: player,
              editCallback: _goToPlayerEdit,
              deleteCallback: _deletePlayer,
            ) : null,
            center: ListView(
              children: <Widget>[
                PlayerCard(player: player),
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
            top: appBar,
            center: ErrorDisplay(
              errorMessage: 'Could not load game data',
            ),
          );
        }

        return AppScaffold(
          top: appBar,
          center: CircleLoader(),
        );
      },
    );
  }
}
