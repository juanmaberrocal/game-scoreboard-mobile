// flutter
import 'dart:async';
import 'package:flutter/foundation.dart';
// dependencies
// app
import 'package:game_scoreboard/collections/games.dart';
import 'package:game_scoreboard/models/game.dart';

/*
Class: GamesLibrary
*/
class GamesLibrary with ChangeNotifier {
  Games _games = Games();

  List<Game> get games {
    return _games.records;
  }

  Future<Games> load() async {
    return _games.fetch(
      queryParams: { 'public': 'true' }
    );
  }

  void clear() {
    _games = Games();
  }
}
