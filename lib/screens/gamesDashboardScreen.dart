// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/collections/games.dart';
import 'package:game_scoreboard/widgets/gameCard.dart';

/*
Screen: Games Dashboard
*/
class GamesDashboardScreen extends StatefulWidget {
  @override
  _GamesDashboardScreenState createState() => _GamesDashboardScreenState();
}

class _GamesDashboardScreenState extends State<GamesDashboardScreen> {
  Future<Games> _games;

  @override
  void initState() {
    _games = Games().fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Games>(
      future: _games,
      builder: (BuildContext context, AsyncSnapshot<Games> snapshot) {
        if (snapshot.hasData) {
          final Games games = snapshot.data;
          final List<Widget>GameCards = games.records.map(
            (game) => GameCard(context, game)
          ).toList();

          return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20.0),
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 10.0,
            crossAxisCount: 2,
            children: GameCards,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LayoutBuilder(builder: (context, constraint) {
                  return Icon(Icons.error_outline, size: constraint.biggest.width/2);
                }),
                Text("There was an error loading the games"),
              ],
            ),
          );
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
