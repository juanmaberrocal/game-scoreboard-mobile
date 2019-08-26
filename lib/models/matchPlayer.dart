// flutter
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app

// serializer
part 'matchPlayer.g.dart';

/*
model: MatchPlayer
*/
@JsonSerializable()
class MatchPlayer {
  @JsonKey(fromJson: _stringToInt, toJson: _stringFromInt)
  final int id;
  @JsonKey(name: 'match_id')
  final int matchId;
  @JsonKey(name: 'player_id')
  final int playerId;
  final bool winner;

  MatchPlayer({
    this.id, this.matchId, this.playerId, this.winner,
  });

  factory MatchPlayer.fromJson(Map<String, dynamic> json) => _$MatchPlayerFromJson(json);
  Map<String, dynamic> toJson() => _$MatchPlayerToJson(this);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();
}
