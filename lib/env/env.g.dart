// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildEnvironment _$BuildEnvironmentFromJson(Map<String, dynamic> json) {
  return BuildEnvironment(
    environment:
        BuildEnvironment._stringToFlavor(json['environment'] as String),
    apiRoot: json['apiRoot'] as String,
    rollbarToken: json['rollbarToken'] as String,
  );
}
