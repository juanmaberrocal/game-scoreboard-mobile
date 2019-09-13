// flutter
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:meta/meta.dart';
// dependencies
// app

enum BuildFlavor { production, development, staging }

BuildEnvironment get env => BuildEnvironment();

/*
Singleton: BuildEnvironment
Load environment configurations from file
  based on specified flavor
*/
class BuildEnvironment {
  /// Singleton definition
  static final BuildEnvironment _singleton = BuildEnvironment._internal();
  factory BuildEnvironment() => _singleton;
  BuildEnvironment._internal();

  /// Singleton members
  static Map<String, dynamic> _env;
  final _envJsonMemoizer = AsyncMemoizer<String>();

  Future<Map<String, dynamic>> loadEnv({
    @required flavor,
  }) async {
    if (_env != null) {
      return _env;
    }

    // if env still not loaded
    final String _envFile = _flavorToString(flavor);
    final String _envString = await _envJsonMemoizer.runOnce(() async {
      return await rootBundle.loadString('lib/env/$_envFile.json');
    });

    return _env = jsonDecode(_envString);
  }

  String get environment {
    _checkLoaded();
    return _env['environment'];
  }

  String get apiRoot {
    _checkLoaded();
    return _env['apiRoot'];
  }

  String get rollbarToken {
    _checkLoaded();
    return _env['rollbarToken'];
  }

  ///
  void _checkLoaded() {
    if (_env.isEmpty) {
      throw Exception('Environment not yet loaded!');
    }
  }

  static String _flavorToString(BuildFlavor flavor) {
    switch(flavor) {
      case BuildFlavor.production: {
        return 'prod';
      }
      default: {
        return 'dev';
      }
    }
  }
}
