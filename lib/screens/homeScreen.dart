// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';
// app
import 'package:game_scoreboard/collections/matches.dart';
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/models/match.dart';
import 'package:game_scoreboard/widgets/errorDisplay.dart';

/*
Screen: Home Dashboard
*/
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Matches> _matches;

  @override
  void initState() {
    final int currentId = Provider.of<CurrentPlayer>(context, listen: false).player?.id;
    final Map<String, dynamic> queryParams = {'player_id': currentId.toString()};

    _matches = Matches().fetch(
      queryParams: queryParams,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Matches>(
      future: _matches,
      builder: (BuildContext context, AsyncSnapshot<Matches> snapshot) {
        if (snapshot.hasData) {
          final Matches matches = snapshot.data;

          final List<Game> games = Provider.of<GamesLibrary>(context, listen: false).games;

          final Iterable<Match> matchesWon = matches.records.where((match) => match.winner);
          final double winPct = matchesWon.length / matches.count();

          Map<String, double> gamesPie = {};
          matchesWon.forEach((match) {
            int gameId = match.gameId;
            String gameName = games.firstWhere((game) => game.id == gameId)?.name;

            gamesPie.putIfAbsent(gameName, () => 0);
            gamesPie[gameName]++;
          });

          final Iterable<Match> lastMatches = matches.records.take(5);


          return Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("Games Played:"),
                          Text("${matches.count()}"),
                        ],
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("Games Won:"),
                          Text("${(winPct * 100).toStringAsFixed(0)}%"),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                PieChart(
                  dataMap: gamesPie,
                ),
                Divider(),
                Text("Last 5 Games:"),
                Expanded(
                  child: ListView.separated(
                    itemCount: lastMatches.length,
                    itemBuilder: (context, i) {
                      final Match match = lastMatches.elementAt(i);
                      final int gameId = match.gameId;
                      final String gameName = games.firstWhere((game) => game.id == gameId)?.name;

                      return ListTile(
                        leading: match.winner ? Icon(Icons.star, color: Colors.yellow) : Icon(Icons.star_border),
                        title: Text("${i + 1}. $gameName"),
                      );
                    },
                    separatorBuilder: (context, i) {
                      return Divider(height: 4.0,); 
                    },
                  ),
                ),
              ],
            ),
          );

        } else if (snapshot.hasError) {
          print(snapshot.error);
          return ErrorDisplay(context, "There was an error loading the players");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
