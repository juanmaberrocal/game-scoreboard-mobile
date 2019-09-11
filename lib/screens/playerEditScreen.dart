// flutter
import 'dart:async';
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/models/player.dart';

/*
Screen: Profile
*/
class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({Key key, this.player}) : super(key: key);

  final Player player;

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          switch(index) {
            case 0: {
              Navigator.pop(context);
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
            icon: Icon(Icons.cancel),
            title: Text('Cancel'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            title: Text('Save'),
          ),
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text("foo"),
          ],
        ),
      ),
    );
  }
}
