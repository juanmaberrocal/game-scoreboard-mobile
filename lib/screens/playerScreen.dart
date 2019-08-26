// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/models/player.dart';
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

  @override
  void initState() {
    _player = Player(id: widget.playerId).fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playerNickname),
      ),
      body: FutureBuilder<Player>(
        future: _player,
        builder: (BuildContext context, AsyncSnapshot<Player> snapshot) {
          if (snapshot.hasData) {
            final Player player = snapshot.data;

            return Center(
              child: Text(player.firstName),
            );
          } else if (snapshot.hasError) {
            return ErrorDisplay(context, "There was an error loading the player");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        }
      ),
    );
  }
}
