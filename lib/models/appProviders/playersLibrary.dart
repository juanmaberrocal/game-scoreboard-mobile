// flutter
import 'dart:async';
import 'package:flutter/foundation.dart';
// dependencies
// app
import 'package:game_scoreboard/collections/players.dart';
import 'package:game_scoreboard/models/player.dart';

/*
Class: PlayersLibrary
*/
class PlayersLibrary with ChangeNotifier {
  Players _players = Players();

  List<Player> get players {
    return _players.records;
  }

  Future<Players> load() async {
    return _players.fetch(
      queryParams: { 'public': 'true' }
    );
  }

  void clear() {
    _players = Players();
  }
}
