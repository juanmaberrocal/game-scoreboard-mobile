// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/models/player.dart';
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

  @override
  void initState() {
    _player = Player().fetch(widget.playerId);
    _standings = Player().standings(widget.playerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.playerNickname),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              FutureBuilder<Player>(
                  future: _player,
                  builder: (BuildContext context, AsyncSnapshot<Player> snapshot) {
                    if (snapshot.hasData) {
                      return PlayerCard(player: snapshot.data);
                    } else if (snapshot.hasError) {
                      return ErrorDisplay(
                        errorMessage: 'Could not load player data',
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
