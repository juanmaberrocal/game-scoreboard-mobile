// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) {
  return Match(
    id: JsonModel.stringToInt(json['id'] as String),
    matchId: json['match_id'] as int,
    gameId: json['game_id'] as int,
    winner: json['winner'] as bool,
    results: (json['results'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as bool),
    ),
  );
}

Map<String, dynamic> _$MatchToJson(Match instance) {
  final val = <String, dynamic>{
    'id': JsonModel.stringFromInt(instance.id),
    'match_id': instance.matchId,
    'game_id': instance.gameId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('winner', instance.winner);
  writeNotNull(
      'results', instance.results?.map((k, e) => MapEntry(k.toString(), e)));
  return val;
}
