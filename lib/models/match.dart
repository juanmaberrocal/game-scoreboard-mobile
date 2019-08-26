// flutter
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app

// serializer
part 'match.g.dart';

/*
model: Match
*/
@JsonSerializable()
class Match {
  @JsonKey(fromJson: _stringToInt, toJson: _stringFromInt)
  final int id;
  @JsonKey(name: 'match_id')
  final int matchId;
  @JsonKey(name: 'game_id')
  final int gameId;
  @JsonKey(nullable: true, includeIfNull: false)
  final bool winner;

  Match({
    this.id, this.matchId, this.gameId, this.winner,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();
}
