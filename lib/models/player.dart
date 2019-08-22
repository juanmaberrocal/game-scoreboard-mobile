// flutter
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app

// serializer
part 'player.g.dart';

/*
model: Player
*/
@JsonSerializable()
class Player {
  @JsonKey(fromJson: _stringToInt, toJson: _stringFromInt)
  final int id;
  final String email;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String nickname;

  Player({
    this.id, this.email, this.firstName, this.lastName, this.nickname,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();
}
