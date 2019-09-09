// flutter
import 'dart:async';
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
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
  Future<void> _openAvatarOptions() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Take a Picture'),
                  onTap: () async {
                    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Select from Gallery'),
                ),
              ],
            )
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentPlayer>(
      builder: (context, currentPlayer, child) {
        final Player player = currentPlayer.player;

        return Scaffold(
          appBar: AppBar(
            title: Text(player.nickname),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              switch(index) {
                case 0: {
                  _openAvatarOptions();
                }
                return;
                case 1: {
                  print("edit");
                }
                return;
              }
            },
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
            fixedColor: Theme.of(context).textTheme.caption.color,
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
