// flutter
import 'dart:async';
import 'dart:convert';
// dependencies
// app
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/services/apiServices.dart';


class Games {
  static const _apiPath = 'v1/games';
  List<Game> _records = [];

  List<Game> get records {
    return _records;
  }

  Future<Games> fetch() async {
    List<Game> games = [];

    final response = await ApiServices.get(_apiPath);

    final responseJson = json.decode(response.body);
    final responseData = responseJson['data'];

    responseData.forEach((data) {
      Map<String, dynamic> gameData = {};

      gameData.addAll({'id': data['id']});
      gameData.addAll(data['attributes']);

      Game game = Game.fromJson(gameData);
      games.add(game);
    });

    _records = games;
    return this;
  }

  int count() {
    return _records.length;
  }
}
