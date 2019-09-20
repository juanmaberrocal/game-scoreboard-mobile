// flutter
import 'dart:async';
import 'dart:io';
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app
import 'package:game_scoreboard/models/jsonModel.dart';
import 'package:game_scoreboard/models/role.dart';
import 'package:game_scoreboard/services/apiServices.dart';

// serializer
part 'player.g.dart';

/*
model: Player
*/
@JsonSerializable()
class Player {
  @JsonKey(fromJson: JsonModel.stringToInt, toJson: JsonModel.stringFromInt)
  final int id;
  final String email;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String nickname;
  @JsonKey(fromJson: Role.roleFromString, toJson: Role.roleToString)
  final Role role;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  Player({
    this.id, this.email, this.firstName, this.lastName, this.nickname,
    this.role,
    this.avatarUrl,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  static const String _apiPath = 'v1/players';

  static Future<Player> fetch(int id) async {
    final String url = '$_apiPath/$id';
    final response = await api.get(url);
    final JsonModel jsonModel = JsonModel.fromResponse(response);
    final Player player = Player.fromJson(jsonModel.toRecordData());
    return player;
  }

  Future<Player> update() async {
    final String url = "$_apiPath/$id";
    final response = await api.put(
      url,
      apiBody: {
        'player': toJson(),
      },
    );
    final JsonModel jsonModel = JsonModel.fromResponse(response);
    final Player player = Player.fromJson(jsonModel.toRecordData());
    return player;
  }

  Future<Player> upload(
    {
      String param,
      File file,
    }
  ) async {
    final String url = "$_apiPath/$id";
    final response = await api.upload(
      url,
      apiFile: {
        'param': "player[$param]",
        'file': file,
      },
      apiRequest: 'PUT',
    );
    final String responseString = await response.stream.bytesToString();
    final JsonModel jsonModel = JsonModel.fromStream(responseString, response.statusCode);
    final Player player = Player.fromJson(jsonModel.toRecordData());
    return player;
  }

  Future<List<dynamic>> standings() async {
    final String url = '$_apiPath/$id/standings';

    final response = await api.get(url);
    final JsonModel jsonModel = JsonModel.fromResponse(response);
    return jsonModel.data['attributes']['standings'];
  }
}
