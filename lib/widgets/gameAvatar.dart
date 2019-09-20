// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:cached_network_image/cached_network_image.dart';
// app
import 'package:game_scoreboard/models/game.dart';

class GameAvatar extends StatelessWidget {
  GameAvatar({
    Key key,
    @required this.game,
    this.height = double.infinity,
    this.width = double.infinity,
  }) : super(key: key);

  final Game game;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final bool hasAvatar = game.avatarUrl != null;
    final _MissingAvatar missingAvatar = _MissingAvatar(
      height: height,
      width: width,
    );

    return hasAvatar ? CachedNetworkImage(
      imageUrl: game.avatarUrl,
      imageBuilder: (BuildContext context, ImageProvider imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      placeholder: (context, url) => missingAvatar,
      errorWidget: (context, url, error) => missingAvatar,
    ) : missingAvatar;
  }
}

class _MissingAvatar extends StatelessWidget {
  _MissingAvatar({
    Key key,
    this.height = double.infinity,
    this.width = double.infinity,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Missing-image-232x150.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}