class Player {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String nickname;

  Player({
    this.id, this.email, this.first_name, this.last_name, this.nickname,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      nickname: json['nickname'],
    );
  }
}
