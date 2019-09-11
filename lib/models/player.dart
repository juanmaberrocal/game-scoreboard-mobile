// flutter
import 'dart:async';
import 'dart:convert';
import 'dart:io';
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app
import 'package:game_scoreboard/services/apiServices.dart';

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
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  Player({
    this.id, this.email, this.firstName, this.lastName, this.nickname,
    this.avatarUrl,
  });

  static String _apiPath = 'v1/players';

  Map<String, dynamic> _parseResponseString({
    String responseString,
    int responseCode,
    List<int> validResponseCodes = const [200, 201, 204]
  }) {
    final responseJson = json.decode(responseString);

    if (validResponseCodes.contains(responseCode)) {
      final responseData = responseJson['data'];
      return responseData;
    } else {
      final responseError = responseJson['error'] ?? 'Oops Something Went Wrong';
      throw(responseError);
    }
  }

  Player _parseResponseDataToPlayer({
    Map<String, dynamic> responseData
  }) {
    Map<String, dynamic> playerData = {};
    playerData.addAll({'id': responseData['id']});
    playerData.addAll(responseData['attributes']);

    Player player = Player.fromJson(playerData);
    return player;
  }

  Future<Player> fetch(int id) async {
    final String url = '$_apiPath/$id';
    final response = await ApiServices.get(url);
    final Map<String, dynamic> responseData = _parseResponseString(
      responseString: response.body,
      responseCode: response.statusCode,
    );
    final Player player = _parseResponseDataToPlayer(responseData: responseData);

    return player;
  }

  Future<Player> update() async {
    final String url = "$_apiPath/$id";
    final response = await ApiServices.put(
      url,
      apiBody: toJson(),
    );
    final Map<String, dynamic> responseData = _parseResponseString(
      responseString: response.body,
      responseCode: response.statusCode,
    );
    final Player player = _parseResponseDataToPlayer(responseData: responseData);

    return player;
  }

  Future<Player> upload(
    {
      String param,
      File file,
    }
  ) async {
    final String url = "$_apiPath/$id";
    final response = await ApiServices.upload(
      url,
      apiFile: {
        'param': "player[$param]",
        'file': file,
      },
      apiRequest: 'PUT',
    );
    final String responseString = await response.stream.bytesToString();
    final Map<String, dynamic> responseData = _parseResponseString(
      responseString: responseString,
      responseCode: response.statusCode,
    );
    final Player player = _parseResponseDataToPlayer(responseData: responseData);

    return player;
  }

  Future<List<dynamic>> standings(int id) async {
    final String url = '$_apiPath/$id/standings';

    final response = await ApiServices.get(url);
    final Map<String, dynamic> responseData = _parseResponseString(
      responseString: response.body,
      responseCode: response.statusCode,
    );

    return responseData['attributes']['standings'];
  }

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();
}
