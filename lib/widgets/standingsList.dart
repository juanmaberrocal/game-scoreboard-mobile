// flutter
import 'package:flutter/material.dart';
// dependencies
// app

/*
Widget: StandingsList
*/
Widget StandingsList(BuildContext context, List standings) {
  double dividerHeight = 4.0;

  return Expanded(
    child: ListView.separated(
      itemCount: standings.length,
      itemBuilder: (context, i) {
        final Map<String, dynamic> standing = standings.elementAt(i);
        final String playerName = standing['name'];
        final int position = standing['position'];
        final int numWins = standing['num_won'];

        return ListTile(
          leading: Text("${i + 1}."),
          title: Text(playerName),
          subtitle: Text("Wins: $numWins"),
          trailing: position == 1 ? Icon(Icons.star, color: Colors.yellow) : Icon(Icons.star_border),
        );
      },
      separatorBuilder: (context, i) {
        return Divider(height: dividerHeight,); 
      },
    ),
  );
}
