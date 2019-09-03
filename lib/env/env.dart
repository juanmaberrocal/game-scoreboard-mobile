// flutter
// import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:meta/meta.dart';
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app

// serializer
part 'env.g.dart';

enum BuildFlavor { production, development, staging }

BuildEnvironment get env => _env;
BuildEnvironment _env;

/*
Singleton: BuildEnvironment
*/
@JsonSerializable(nullable: false, createToJson: false)
class BuildEnvironment {
  @JsonKey(fromJson: _stringToFlavor)
  final BuildFlavor environment;
  final String apiRoot;
  final String rollbarToken;

  /// Sets up the top-level [env] getter on the first call only.
  static void init({@required flavor,}) async {
    final String envFile = _flavorToString(flavor);
    final String envString = await rootBundle.loadString('lib/env/$envFile.json');
    final Map<String, dynamic> envJson = json.decode(envString);

    _env ??= BuildEnvironment._init(envJson);
  }

  BuildEnvironment({
    this.environment,
    this.apiRoot,
    this.rollbarToken,
  });

  factory BuildEnvironment._init(Map<String, dynamic> json) => _$BuildEnvironmentFromJson(json);

  static BuildFlavor _stringToFlavor(String flavor) {
    return BuildFlavor.values.firstWhere((e) => e.toString() == 'BuildFlavor.' + flavor);
  }

  static String _flavorToString(BuildFlavor flavor) {
    switch(flavor) {
      case BuildFlavor.production: {
        return 'prod';
      }
      break;

      default: {
        return 'dev';
      }
      break;
    }
  }
}
