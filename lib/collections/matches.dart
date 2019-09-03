// flutter
import 'dart:async';
import 'dart:convert';
// dependencies
// app
import 'package:game_scoreboard/models/match.dart';
import 'package:game_scoreboard/services/apiServices.dart';

/*
Collection: Matches
*/
class Matches {
  static const _apiPath = 'v1/matches';
  List<Match> _records = <Match>[];

  List<Match> get records {
    return _records;
  }

  Future<Matches> fetch({
    Map<String, dynamic> queryParams,
  }) async {
    List<Match> matches = [];

    final response = await ApiServices.get(_apiPath, apiBody: queryParams);

    final responseJson = json.decode(response.body,);
    final responseData = responseJson['data'];

    responseData.forEach((data) {
      Map<String, dynamic> matchData = {};

      matchData.addAll({'id': data['id']});
      matchData.addAll(data['attributes']);

      Match match = Match.fromJson(matchData);
      matches.add(match);
    });

    _records = matches;
    return this;
  }

  int count() {
    return _records.length;
  }
}
