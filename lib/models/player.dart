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

  Future<Player> fetch() async {
    final String apiPath = 'v1/players';
    final String url = '${apiPath}/${this.id}';
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

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();
}
