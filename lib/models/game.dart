// flutter
import 'dart:async';
import 'dart:convert';
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app
import 'package:game_scoreboard/models/jsonModel.dart';
import 'package:game_scoreboard/services/apiServices.dart';

// serializer
part 'game.g.dart';

/*
model: Game
*/
@JsonSerializable()
class Game with JsonModel {
  @JsonKey(fromJson: JsonModel.stringToInt, toJson: JsonModel.stringFromInt)
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
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  Game({
    this.id, this.name, this.description,
    this.minPlayers, this.maxPlayers,
    this.minPlayTime, this.maxPlayTime,
    this.avatarUrl,
  });

  static String _apiPath = 'v1/games';

  Future<Game> fetch(int id) async {
    final String url = '$_apiPath/$id';
    final response = await api.get(url);
    final Map<String, dynamic> responseData = parseResponseString(
      responseString: response.body,
      responseCode: response.statusCode,
    );

    final Game game = Game.fromJson(parseResponseDataToRecordData(responseData: responseData));
    return game;
  }

  Future<List<dynamic>> standings(int id) async {
    final String url = '$_apiPath/$id/standings';

    final response = await api.get(url);
    final responseJson = json.decode(response.body);
    final responseData = responseJson['data'];

    return responseData['attributes']['standings'];
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
