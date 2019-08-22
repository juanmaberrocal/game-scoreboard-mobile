// flutter
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app

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

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();
}
