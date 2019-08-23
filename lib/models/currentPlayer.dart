// flutter
import 'dart:async';
import 'package:flutter/foundation.dart';
// dependencies
// app
import 'package:game_scoreboard/data/storedUser.dart';
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/services/authorizationServices.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

/*
Class: CurrentPlayer
*/
class CurrentPlayer with ChangeNotifier {
  Player player;
  Status _status = Status.Uninitialized;

  void _parseResponse(Map<String, dynamic> response) {
    final String token = response['token'];
    final Map<String, dynamic> data = response['body']['data'];

    Map<String, dynamic> json = {};
    json.addAll({'id': data['id']});
    json.addAll(data['attributes']);

    _setCurrentPlayer(
      token,
      Player.fromJson(json),
    );
  }

  void _setCurrentPlayer(String token, Player _player) {
    StoredUser.setToken(token);

    _status = Status.Authenticated;
    player = _player;
    notifyListeners();
  }

  void _clearCurrentPlayer() {
    StoredUser.clear();
    _status = Status.Unauthenticated;
    player = null;
    notifyListeners();
  }

  Future<bool> renew() async {
    final String token = await StoredUser.getToken();
    bool isRenewed;

    if (token == null){
      return false;
    }

    await AuthorizationServices.renewToken().then((Map<String, dynamic> renewResponse) {
      // store user token and set player record
      _parseResponse(renewResponse);
      isRenewed = true;
    }).catchError((err) {
      // ensure all stored data is cleared
      _clearCurrentPlayer();
      isRenewed = false;
    });

    return isRenewed;
  }

  Future<void> logIn(String email, String password) async {
    _status = Status.Authenticating;

    await AuthorizationServices.logIn(
      email,
      password
    ).then((Map<String, dynamic> loginResponse) {
      // if sign in succeeded
      // store user token and set player record
      _parseResponse(loginResponse);
    }).catchError((err) {
      // if sign in failed
      // ensure all stored data is cleared
      _clearCurrentPlayer();
      throw err;
    });
  }

  Future<void> logOut() async {
    _status = Status.Authenticating;

    await AuthorizationServices.logOut().then((void _) {
      _clearCurrentPlayer();
    }).catchError((err) {
      // if sign in failed
      // ensure all stored data is cleared
      _clearCurrentPlayer();
      throw err;
    });
  }
}