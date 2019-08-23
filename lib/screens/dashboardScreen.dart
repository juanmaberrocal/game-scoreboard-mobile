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
  final int _initialTabIndex = 1;
  bool _displayFAB = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: _initialTabIndex, length: 3);
    _tabController.animation.addListener(_onTabChanged);
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
        floatingActionButton: _displayFAB ? FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ) : null,
      )
    );
  }

  void _onTabChanged() {
    final tabIndex = _tabController.index;
    final aniValue = _tabController.animation.value;

    final bool displayFAB = ((aniValue > 0.5 || aniValue < 1.5) && tabIndex == 1) ? true : false;
    setState(() {
      _displayFAB = displayFAB;
    });
  }
}
