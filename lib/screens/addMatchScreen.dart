// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/collections/matches.dart';
import 'package:game_scoreboard/models/match.dart';

/*
Screen: Add Match
*/
class AddMatchScreen extends StatefulWidget {
  @override
  _AddMatchScreenState createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Match"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text("foo"),
          ],
        ),
      ),
    );
  }
}
