// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    id: JsonModel.stringToInt(json['id'] as String),
    name: json['name'] as String,
    description: json['description'] as String,
    minPlayers: json['min_players'] as int,
    maxPlayers: json['max_players'] as int,
    minPlayTime: json['min_play_time'] as int,
    maxPlayTime: json['max_play_time'] as int,
    avatarUrl: json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': JsonModel.stringFromInt(instance.id),
      'name': instance.name,
      'description': instance.description,
      'min_players': instance.minPlayers,
      'max_players': instance.maxPlayers,
      'min_play_time': instance.minPlayTime,
      'max_play_time': instance.maxPlayTime,
      'avatar_url': instance.avatarUrl,
    };
