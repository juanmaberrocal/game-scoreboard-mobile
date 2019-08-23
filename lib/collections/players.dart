// flutter
import 'dart:async';
import 'dart:convert';
// dependencies
// app
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/services/apiServices.dart';


class Players {
  static const _apiPath = 'v1/players';
  List<Player> _records = [];

  List<Player> get records {
    return _records;
  }

  Future<Players> fetch() async {
    List<Player> players = [];

    final response = await ApiServices.get(_apiPath);

    final responseJson = json.decode(response.body);
    final responseData = responseJson['data'];

    responseData.forEach((data) {
      Map<String, dynamic> playerData = {};

      playerData.addAll({'id': data['id']});
      playerData.addAll(data['attributes']);

      Player player = Player.fromJson(playerData);
      players.add(player);
    });

    _records = players;
    return this;
  }

  int count() {
    return _records.length;
  }
}