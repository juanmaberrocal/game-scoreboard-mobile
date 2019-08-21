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

  void _setCurrentUser(String token, Player player) {
    StoredUser.setToken(token);
    _status = Status.Authenticated;
    player = player;
    notifyListeners();
  }

  void _clearCurrentUser() {
    StoredUser.clear();
    _status = Status.Unauthenticated;
    player = null;
    notifyListeners();
  }

  Future<void> logIn(String email, String password) async {
    _status = Status.Authenticating;

    await AuthorizationServices.logIn(
      email,
      password
    ).then((Map<String, dynamic> loginResponse) {
      // if sign in succeeded
      // store user token and set player record
      _setCurrentUser(
        loginResponse['token'],
        Player.fromJson(loginResponse['body']),
      );
    }).catchError((err) {
      // if sign in failed
      // ensure all stored data is cleared
      _clearCurrentUser();
      throw err;
    });
  }

  Future<void> logOut() async {
    _status = Status.Authenticating;

    await AuthorizationServices.logOut().then((void _) {
      _clearCurrentUser();
    }).catchError((err) {
      // if sign in failed
      // ensure all stored data is cleared
      _clearCurrentUser();
      throw err;
    });
  }
}
