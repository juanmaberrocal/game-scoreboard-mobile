// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/widgets/standingListElement.dart';

/*
Widget: StandingList
Builds a List displaying the standing data provided

List<dynamic> standingsData: Array of JSON data object [required]
  |- name: String
  |- position: int
  |- num_won: int
String title: Header for list
int dividerHeight: Height of divider line built between list elements
 */
class StandingList extends StatelessWidget {
  StandingList({
    Key key,
    @required this.standingsData,
    this.title = 'Standings:',
    this.dividerHeight = 0.0,
  }) : super(key: key);

  final List<dynamic> standingsData;
  final String title;
  final double dividerHeight;

  final double listHeightMultiplier = 85.0;
  final double listHeightFixed = 375.0;

  int listLength() {
    return standingsData.length;
  }

  double listHeight() {
    return listLength() < 5 ?
        listLength() * listHeightMultiplier :
        listHeightFixed;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeight(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            decoration: BoxDecoration(
//              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(5.0),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
//                color: Colors.white,
//                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
//                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                ),
              ),
              child: ListView.separated(
                itemCount: listLength(),
                itemBuilder: (BuildContext context, int index) {
                  final Map<String, dynamic> standingData = standingsData.elementAt(index);

                  return StandingListElement(
                    index: index,
                    standingData: standingData,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: dividerHeight,);
                },
                physics: ClampingScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
