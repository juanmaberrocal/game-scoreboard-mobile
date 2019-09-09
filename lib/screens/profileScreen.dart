// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/widgets/playerCard.dart';

/*
Screen: Profile
*/
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentPlayer>(
      builder: (context, CurrentPlayer, child) {
        final Player player = CurrentPlayer.player;

        return Scaffold(
          appBar: AppBar(
            title: Text(player.nickname),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                title: Text('Avatar'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                title: Text('Edit'),
              ),
            ],
            selectedItemColor: Theme.of(context).textTheme.caption.color,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                PlayerCard(player: player,),
              ],
            ),
          ),
        ); 
      },
    );
  }
}
