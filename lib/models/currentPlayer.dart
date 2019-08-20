import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/data/storedUser.dart';

class CurrentPlayer extends Player {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String nickname;

  CurrentPlayer({
    this.id, this.email, this.first_name, this.last_name, this.nickname,
  }) : super();

  factory CurrentPlayer.fromJson(Map<String, dynamic> json, String token) {
    StoredUser.setToken(token);

    return CurrentPlayer(
      id: json['id'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      nickname: json['nickname'],
    );
  }

  /* @override
  void dispose() {
    StoredUser.clear();
    super.dispose();
  } */
}
