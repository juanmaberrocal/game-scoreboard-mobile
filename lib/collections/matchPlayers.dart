// flutter
import 'dart:async';
import 'dart:convert';
// dependencies
// app
import 'package:game_scoreboard/models/matchPlayer.dart';
import 'package:game_scoreboard/services/apiServices.dart';


class MatchPlayers {
  static const _apiPath = 'v1/match_players';
  List<MatchPlayer> _records = [];

  List<MatchPlayer> get records {
    return _records;
  }

  Future<MatchPlayers> fetch({
    Map<String, dynamic> queryParams,
  }) async {
    List<MatchPlayer> matchPlayers = [];

    final response = await api.get(_apiPath, apiBody: queryParams);

    final responseJson = json.decode(response.body,);
    final responseData = responseJson['data'];

    responseData.forEach((data) {
      Map<String, dynamic> matchPlayerData = {};

      matchPlayerData.addAll({'id': data['id']});
      matchPlayerData.addAll(data['attributes']);

      MatchPlayer matchPlayer = MatchPlayer.fromJson(matchPlayerData);
      matchPlayers.add(matchPlayer);
    });

    _records = matchPlayers;
    return this;
  }

  int count() {
    return _records.length;
  }

  Map<int, dynamic> winPctMap() {
    Map<int, dynamic> _winPctMap = {};

    _records.forEach((record) {
      final int playerId = record.playerId;
      final bool winner = record.winner;

      _winPctMap.putIfAbsent(playerId, () => { 'wins': 0, 'total': 0 });
      _winPctMap[playerId]['total']++;

      if (winner) {
        _winPctMap[playerId]['wins']++;
      }
    });

    return _winPctMap;
  }
}
