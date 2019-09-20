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
class Player with JsonModel {
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

  final String _apiPath = 'v1/players';

  Future<Player> fetch(int id) async {
    final String url = '$_apiPath/$id';
    final response = await api.get(url);
    final Map<String, dynamic> responseData = parseResponseString(
      responseString: response.body,
      responseCode: response.statusCode,
    );

    final Player player = Player.fromJson(parseResponseDataToRecordData(responseData: responseData));
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
    final Map<String, dynamic> responseData = parseResponseString(
      responseString: response.body,
      responseCode: response.statusCode,
    );

    final Player player = Player.fromJson(parseResponseDataToRecordData(responseData: responseData));
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
    final Map<String, dynamic> responseData = parseResponseString(
      responseString: responseString,
      responseCode: response.statusCode,
    );

    final Player player = Player.fromJson(parseResponseDataToRecordData(responseData: responseData));
    return player;
  }

  Future<List<dynamic>> standings(int id) async {
    final String url = '$_apiPath/$id/standings';

    final response = await api.get(url);
    final Map<String, dynamic> responseData = parseResponseString(
      responseString: response.body,
      responseCode: response.statusCode,
    );

    return responseData['attributes']['standings'];
  }
}
