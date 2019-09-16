// flutter
// dependencies
import 'package:json_annotation/json_annotation.dart';
// app
import 'package:game_scoreboard/models/jsonModel.dart';
import 'package:game_scoreboard/services/apiServices.dart';

// serializer
part 'match.g.dart';

/*
model: Match
*/
@JsonSerializable()
class Match with JsonModel {
  @JsonKey(fromJson: JsonModel.stringToInt, toJson: JsonModel.stringFromInt)
  final int id;
  @JsonKey(name: 'match_id')
  final int matchId;
  @JsonKey(name: 'game_id')
  final int gameId;
  @JsonKey(nullable: true, includeIfNull: false)
  final bool winner;
  @JsonKey(nullable: true, includeIfNull: false)
  final Map<int, bool> results;

  Match({
    this.id, this.matchId, this.gameId, this.winner, this.results,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);

  static String _apiPath = 'v1/matches';

  Future<Match> create() async {
    final String url = "$_apiPath/";
    final response = await api.post(
      url,
      apiBody: {
        'match': toJson(),
      },
    );
    final Map<String, dynamic> responseData = parseResponseString(
      responseString: response.body,
      responseCode: response.statusCode,
    );

    final Match match = Match.fromJson(parseResponseDataToRecordData(responseData: responseData));
    return match;
  }
}
