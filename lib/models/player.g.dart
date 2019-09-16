// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
    id: JsonModel.stringToInt(json['id'] as String),
    email: json['email'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    nickname: json['nickname'] as String,
    avatarUrl: json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': JsonModel.stringFromInt(instance.id),
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'nickname': instance.nickname,
      'avatar_url': instance.avatarUrl,
    };
