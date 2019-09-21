// flutter
import 'dart:async';
import 'dart:io';
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
class Game {
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

  static const String _apiPath = 'v1/games';

  static Future<Game> fetch(int id) async {
    final String url = '$_apiPath/$id';
    final response = await api.get(url);
    final JsonModel jsonModel = JsonModel.fromResponse(response);
    final Game game = Game.fromJson(jsonModel.toRecordData());
    return game;
  }

  Future<Game> update() async {
    final String url = "$_apiPath/$id";
    final response = await api.put(
      url,
      apiBody: {
        'game': toJson(),
      },
    );
    final JsonModel jsonModel = JsonModel.fromResponse(response);
    final Game game = Game.fromJson(jsonModel.toRecordData());
    return game;
  }

  Future<Game> upload(
      {
        String param,
        File file,
      }
      ) async {
    final String url = "$_apiPath/$id";
    final response = await api.upload(
      url,
      apiFile: {
        'param': "game[$param]",
        'file': file,
      },
      apiRequest: 'PUT',
    );
    final String responseString = await response.stream.bytesToString();
    final JsonModel jsonModel = JsonModel.fromStream(responseString, response.statusCode);
    final Game game = Game.fromJson(jsonModel.toRecordData());
    return game;
  }

  Future<List<dynamic>> standings() async {
    final String url = '$_apiPath/$id/standings';

    final response = await api.get(url);
    final JsonModel jsonModel = JsonModel.fromResponse(response);
    return jsonModel.data['attributes']['standings'];
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
