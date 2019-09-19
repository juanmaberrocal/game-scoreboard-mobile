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
import 'package:game_scoreboard/widgets/circleLoader.dart';
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
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: FutureBuilder<Matches>(
        future: _matches,
        builder: (BuildContext context, AsyncSnapshot<Matches> snapshot) {
          if (snapshot.hasData) {
            final Matches matches = snapshot.data;

            final List<Game> games = Provider.of<GamesLibrary>(context, listen: false).games;

            final Iterable<Match> lastMatches = matches.records.take(5);

            return ListView(
              children: <Widget>[
                _HomeBody(matches: matches,),
                Container(
                  height: 375.0,
                  child: ListView.separated(
                    physics: ClampingScrollPhysics(),
                    itemCount: lastMatches.length,
                    itemBuilder: (context, i) {
                      final Match match = lastMatches.elementAt(i);
                      final int gameId = match.gameId;
                      final String gameName = games.firstWhere((game) => game.id == gameId)?.name;

                      return ListTile(
                        leading: Text("${i + 1}."),
                        title: Text(gameName),
                        subtitle: match.winner ? Text("Won") : Text("Lost"),
                        trailing: match.winner ? Icon(Icons.star, color: Colors.yellow) : Icon(Icons.star_border),
                      );
                    },
                    separatorBuilder: (context, i) {
                      return Divider(height: 4.0,);
                    },
                  ),
                ),
              ],
            );
          }
          else if (snapshot.hasError) {
            return ErrorDisplay(
                errorMessage: "There was an error loading the players"
            );
          }

          // By default, show a loading spinner.
          return CircleLoader();
        },
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  _HomeBody({
    Key key,
    this.matches,
  }) : super(key: key);

  final Matches matches;

  @override
  Widget build(BuildContext context) {
    final List<Game> games = Provider.of<GamesLibrary>(context, listen: false).games;

    final Iterable<Match> matchesWon = matches.records.where((match) => match.winner);
    Map<String, double> gamesPie = {};
    matchesWon.forEach((match) {
      int gameId = match.gameId;
      String gameName = games.firstWhere((game) => game.id == gameId)?.name;

      gamesPie.putIfAbsent(gameName, () => 0);
      gamesPie[gameName]++;
    });

    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.width * 0.33,
                padding: EdgeInsets.only(right: 5.0),
                child: _GamesPlayedCard(matches: matches,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 17.0),
              height: MediaQuery.of(context).size.width * 0.35,
              width: MediaQuery.of(context).size.width * 0.50,
              child: _GamesWonCard(matches: matches,),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Favorite Games",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Card(
                child: PieChart(dataMap: gamesPie),
                elevation: 3.0,
              ),
            ],
          ),
        ),
        Center(
          child: Text("Recent Games:"),
        ),
      ],
    );
  }
}

class _GamesPlayedCard extends StatelessWidget {
  _GamesPlayedCard({
    Key key,
    this.matches,
  }) : super(key: key);

  final Matches matches;

  @override
  Widget build(BuildContext context) {
    final int gamesPlayed = matches.count();

    return Card(
      child: Container(
        height: MediaQuery.of(context).size.width * 0.33,
        padding: EdgeInsets.only(right: 5.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: RotatedBox(
                child: Text(
                  'PLAYED',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                quarterTurns: 1,
              ),
              top: 0.0,
              left: -7.0,
            ),
            Align(
              child: Text(
                "$gamesPlayed",
                style: TextStyle(
                  fontSize: 80,
                ),
              ),
              alignment: Alignment.centerRight,
            ),
          ],
        ),
      ),
    );
  }
}

class _GamesWonCard extends StatelessWidget {
  _GamesWonCard({
    Key key,
    this.matches,
  }) : super(key: key);

  final Matches matches;

  @override
  Widget build(BuildContext context) {
    final List<Match> matchesWon = matches.records.where((match) => match.winner).toList();
    final double winPct = matchesWon.length / matches.count();

    return Card(
      child: Container(
        padding: EdgeInsets.all(0.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Text(
                'WIN %',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              top: -12.0,
              left: 0.0,
            ),
            Positioned(
              child: Text(
                "${(winPct * 100).toStringAsFixed(0)}",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
                  height: 0,
                ),
              ),
              bottom: 0.0,
              right: 2.0,
            ),
          ],
        ),
      ),
      elevation: 5.0,
    );
  }
}