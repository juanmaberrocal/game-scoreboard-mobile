// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:cached_network_image/cached_network_image.dart';
// app
import 'package:game_scoreboard/helpers/colorSelector.dart';
import 'package:game_scoreboard/models/player.dart';

class PlayerAvatar extends StatelessWidget {
  PlayerAvatar({
    Key key,
    @required this.player,
    this.useName,
    this.radius,
  }) : super(key: key);

  final Player player;
  final bool useName;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final bool hasAvatar = player.avatarUrl != null;
    final _NameAvatar nameAvatar = _NameAvatar(
      name: useName ? "${player.firstName} ${player.lastName}" : player.nickname,
      radius: radius,
    );

    return hasAvatar ? CachedNetworkImage(
      imageUrl: player.avatarUrl,
      imageBuilder: (BuildContext context, ImageProvider imageProvider) {
        return CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        );
      },
      placeholder: (context, url) => nameAvatar,
      errorWidget: (context, url, error) => nameAvatar,
    ) : nameAvatar;
  }
}

class _NameAvatar extends StatelessWidget {
  _NameAvatar({
    Key key,
    @required this.name,
    @required this.radius,
  }) : super(key: key);

  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final String initials = name.split(' ').map((String n) => n[0]).join(' ');
    return CircleAvatar(
      radius: radius,
      backgroundColor: ColorSelector().fromString(initials),
      child: Text(initials),
    );
  }
}