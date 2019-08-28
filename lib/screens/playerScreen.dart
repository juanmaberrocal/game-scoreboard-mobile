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

                  return Center(
                    child: Text("${player.firstName} ${player.lastName}"),
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
                  
                  return Expanded(
                    child: ListView.separated(
                      itemCount: standings.length,
                      itemBuilder: (context, i) {
                        final Map<String, dynamic> standing = standings.elementAt(i);
                        final String player = standing['name'];
                        final int position = standing['position'];
                        final int numWins = standing['num_won'];

                        return ListTile(
                          leading: Text("${i + 1}."),
                          title: Text(player),
                          subtitle: Text("Wins: $numWins"),
                          trailing: position == 1 ? Icon(Icons.star, color: Colors.yellow) : Icon(Icons.star_border),
                        );
                      },
                      separatorBuilder: (context, i) {
                        return Divider(height: 4.0,); 
                      },
                    ),
                  );
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
