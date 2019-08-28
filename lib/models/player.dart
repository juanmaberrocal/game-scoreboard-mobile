// flutter
import 'dart:async';
import 'dart:convert';
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app
import 'package:game_scoreboard/services/apiServices.dart';

// serializer
part 'player.g.dart';

/*
model: Player
*/
@JsonSerializable()
class Player {
  @JsonKey(fromJson: _stringToInt, toJson: _stringFromInt)
  final int id;
  final String email;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String nickname;

  Player({
    this.id, this.email, this.firstName, this.lastName, this.nickname,
  });

  static String _apiPath = 'v1/players';

  Future<Player> fetch(int id) async {
    final String url = '${_apiPath}/${id}';
    Player player;

    final response = await ApiServices.get(url);

    final responseJson = json.decode(response.body);
    final responseData = responseJson['data'];

    Map<String, dynamic> playerData = {};
    playerData.addAll({'id': responseData['id']});
    playerData.addAll(responseData['attributes']);

    player = Player.fromJson(playerData);
    return player;
  }

  Future<List<dynamic>> standings(int id) async {
    final String url = '${_apiPath}/${id}/standings';

    final response = await ApiServices.get(url);
    final responseJson = json.decode(response.body);
    final responseData = responseJson['data'];

    return responseData['attributes']['standings'];
  }

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();
}
