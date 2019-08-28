// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/helpers/colorSelector.dart';
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/widgets/standingsList.dart';
import 'package:game_scoreboard/widgets/errorDisplay.dart';

/*
Screen: Player
*/
class PlayerScreen extends StatefulWidget {
  PlayerScreen({Key key, this.playerId, this.playerNickname}) : super(key: key);

  final int playerId;
  final String playerNickname;

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  Future<Player> _player;
  Future<List> _standings;

  @override
  void initState() {
    _player = Player(id: widget.playerId).fetch();
    _standings = Player().standings(widget.playerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playerNickname),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<Player>(
              future: _player,
              builder: (BuildContext context, AsyncSnapshot<Player> snapshot) {
                if (snapshot.hasData) {
                  final Player player = snapshot.data;

                  return Column(
                    children: <Widget>[
                      CircleAvatar(
                        minRadius: 50,
                        backgroundColor: getColorFromString(player.nickname),
                        child: Text("${player.firstName[0]}${player.lastName[0]}"),
                      ),
                      Text("${player.firstName} ${player.lastName}"),
                      Text(player.email),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return ErrorDisplay(context, "There was an error loading the player");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              }
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
