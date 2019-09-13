// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/screens/addMatchScreen.dart';
import 'package:game_scoreboard/screens/gamesScreen.dart';
import 'package:game_scoreboard/screens/homeScreen.dart';
import 'package:game_scoreboard/screens/playersScreen.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: _initialTabIndex, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HideFabOnTabSwitchScaffold(
      appBar: MainAppBar(
        context,
        _tabController
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: GamesScreen(),
          ),
          Center(
            child: HomeScreen(),
          ),
          Center(
            child: PlayersScreen(),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMatchScreen()
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      controller: _tabController,
    );
  }
}

class HideFabOnTabSwitchScaffold extends StatefulWidget {
  const HideFabOnTabSwitchScaffold({
    Key key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.controller,
  }) : super(key: key);

  final Widget appBar;
  final Widget body;
  final Widget floatingActionButton;
  final TabController controller;

  @override
  _HideFabOnTabSwitchScaffoldState createState() => _HideFabOnTabSwitchScaffoldState();
}

class _HideFabOnTabSwitchScaffoldState extends State<HideFabOnTabSwitchScaffold> {
  bool _displayFAB = true;

  @override
  void initState() {
    super.initState();
    widget.controller.animation.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    widget.controller.animation.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    final tabIndex = widget.controller.index;
    final aniValue = widget.controller.animation.value;

    final bool displayFAB = ((aniValue > 0.5 || aniValue < 1.5) && tabIndex == 1) ? true : false;
    setState(() {
      _displayFAB = displayFAB;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: widget.appBar,
        body: widget.body,
        floatingActionButton: _displayFAB ? widget.floatingActionButton : null,
      ),
    );
  }
}
