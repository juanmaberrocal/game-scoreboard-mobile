// flutter
import 'dart:async';
import 'dart:convert';
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app
import 'package:game_scoreboard/services/apiServices.dart';

// serializer
part 'game.g.dart';

/*
model: Game
*/
@JsonSerializable()
class Game {
  @JsonKey(fromJson: _stringToInt, toJson: _stringFromInt)
  final int id;
  final String name;
  final String description;
  @JsonKey(name: 'min_players')
  final int minPlayers;
  @JsonKey(name: 'max_players')
  final int maxPlayers;
  @JsonKey(name: 'min_play_time')
  final int minPlayTime;
  @JsonKey(name: 'max_play_time')
  final int maxPlayTime;

  Game({
    this.id, this.name, this.description,
    this.minPlayers, this.maxPlayers,
    this.minPlayTime, this.maxPlayTime,
  });

  static String _apiPath = 'v1/games';

  Future<Game> fetch(int id) async {
    final String url = '$_apiPath/$id';
    Game game;

    final response = await ApiServices.get(url);

    final responseJson = json.decode(response.body);
    final responseData = responseJson['data'];

    Map<String, dynamic> gameData = {};
    gameData.addAll({'id': responseData['id']});
    gameData.addAll(responseData['attributes']);

    game = Game.fromJson(gameData);
    return game;
  }

  Future<List<dynamic>> standings(int id) async {
    final String url = '$_apiPath/$id/standings';

    final response = await ApiServices.get(url);
    final responseJson = json.decode(response.body);
    final responseData = responseJson['data'];

    return responseData['attributes']['standings'];
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();
}
