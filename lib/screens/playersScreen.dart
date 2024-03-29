// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/appProviders/playersLibrary.dart';
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/screens/playerScreen.dart';
import 'package:game_scoreboard/widgets/playerAvatar.dart';

/*
Screen: Players Dashboard
*/
class PlayersScreen extends StatefulWidget {
  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayersLibrary>(
      builder: (context, playersLibrary, child) {
        final List<Widget> playerCards = playersLibrary.players.map(
                (player) => _PlayerListElement(player: player,)
        ).toList()..sort((a, b) => a.player.nickname.compareTo(b.player.nickname));

        return RefreshIndicator(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            primary: false,
            padding: const EdgeInsets.all(20.0),
            children: playerCards,
          ),
          onRefresh: () {
            return Provider.of<PlayersLibrary>(context, listen: false).load();
          }
        );
      },
    );
  }
}

class _PlayerListElement extends StatelessWidget {
  _PlayerListElement({
    Key key,
    @required this.player,
  }) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayerScreen(
                playerId: player.id,
                playerNickname: player.nickname,
              ),
            ),
          );
        },
        child: ListTile(
          leading: PlayerAvatar(
            player: player,
            useName: false,
          ),
          title: Text(
            player.nickname,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
