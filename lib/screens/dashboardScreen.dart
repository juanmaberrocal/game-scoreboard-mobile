// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/currentPlayer.dart';
import 'package:game_scoreboard/screens/gamesDashboardScreen.dart';
import 'package:game_scoreboard/widgets/mainAppBar.dart';

/*
Screen: Dashboard
*/
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 1, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          context,
          _tabController
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Center(
              child: GamesDashboardScreen(),
            ),
            Center(
              child: Consumer<CurrentPlayer>(
                builder: (context, currentPlayer, child) {
                  return Text('Total price: ${currentPlayer.player?.nickname}');
                },
              ),
            ),
            Center(
              child: Consumer<CurrentPlayer>(
                builder: (context, currentPlayer, child) {
                  return Text('Total price: ${currentPlayer.player?.firstName}');
                },
              ),
            ),
          ]
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // TODO:
          }
        ),
      )
    );
  }
}
