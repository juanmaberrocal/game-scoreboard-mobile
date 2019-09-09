// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// dependencies
// app

/*
Widget: StandingListElement
Builds a ListTile displaying:
  * Title: the name of the record for the standing,
  * Subtitle: the number of wins for the standing
  * Header: the standing position,
  * Trailing: UI icon to display win/loss

int index: [required]
Map<String, dynamic> standingData: JSON data object [required]
  |- name: String
  |- position: int
  |- num_won: int
 */
class StandingListElement extends StatelessWidget {
  StandingListElement({
    Key key,
    @required this.index,
    @required this.standingData,
  }) : super(key: key);

  final int index;
  final Map<String, dynamic> standingData;

  @override
  Widget build(BuildContext context) {
    final String name = standingData['name'];
    final int position = standingData['position'];
    final int numWins = standingData['num_won'];

    return ListTile(
      leading: Text("${index + 1}."),
      title: Text(name),
      subtitle: Text("Wins: $numWins"),
      trailing: position == 1 ?
      Icon(Icons.star, color: Colors.yellow) :
      Icon(Icons.star_border),
    );
  }
}
