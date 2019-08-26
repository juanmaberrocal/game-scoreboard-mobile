// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchPlayer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchPlayer _$MatchPlayerFromJson(Map<String, dynamic> json) {
  return MatchPlayer(
    id: MatchPlayer._stringToInt(json['id'] as String),
    matchId: json['match_id'] as int,
    playerId: json['player_id'] as int,
    winner: json['winner'] as bool,
  );
}

Map<String, dynamic> _$MatchPlayerToJson(MatchPlayer instance) =>
    <String, dynamic>{
      'id': MatchPlayer._stringFromInt(instance.id),
      'match_id': instance.matchId,
      'player_id': instance.playerId,
      'winner': instance.winner,
    };
