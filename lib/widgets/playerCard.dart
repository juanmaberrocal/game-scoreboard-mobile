// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/helpers/colorSelector.dart';
import 'package:game_scoreboard/models/player.dart';

/*
Widget: PlayerCard
Builds a ListTile displaying:

Player player: [required]
 */

class PlayerCard extends StatelessWidget {
  PlayerCard({
    Key key,
    @required this.player
  }) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50.0),
          width: double.infinity,
          child: Card(
            child: _CardBody(player: player,),
          ),
        ),
        Center(
          child: _CardAvatar(player: player,),
        ),
      ],
    );
  }
}

class _CardBody extends StatelessWidget {
  _CardBody({
    Key key,
    this.player,
  }) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
      child: Column(
        children: <Widget>[
          LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              width: constraints.maxWidth * 0.75,
              child: Column(
                children: <Widget>[
                  Text(
                    "${player.firstName} ${player.lastName}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(player.email),
                ],
              ),
            );
          }),
          Padding(padding: EdgeInsets.all(18.0),),
          LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: constraints.maxWidth * 0.33,
                      child: Text(
                        'Nickname: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(player.nickname),
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _CardAvatar extends StatelessWidget {
  _CardAvatar({
    Key key,
    this.player,
    this.radius = 50.0,
  }) : super(key: key);

  final Player player;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final String initials = "${player.firstName[0]}${player.lastName[0]}";
    final String url = player.avatarUrl ?? "";

    return CircleAvatar(
      radius: radius,
      backgroundColor: ColorSelector().fromString(player.nickname),
      child: (
        player.avatarUrl == null ? Text(initials) : null
      ),
      backgroundImage: (
        player.avatarUrl != null ? NetworkImage(url) : null
      ),
    );
  }
}