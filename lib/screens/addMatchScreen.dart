// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// dependencies
// app
import 'package:game_scoreboard/collections/matches.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/appProviders/playersLibrary.dart';
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/models/match.dart';

/*
Screen: Add Match
*/
class _AddMatchData extends InheritedWidget {
  _AddMatchData({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // Data is your entire state. In our case just 'User'
  final _AddMatchScreenState data;

  @override
  bool updateShouldNotify(_AddMatchData oldWidget) => true;
}

class AddMatchScreen extends StatefulWidget {
  static _AddMatchScreenState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_AddMatchData) as _AddMatchData).data;
  }

  @override
  _AddMatchScreenState createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  // Player form identifier key
  final _matchFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    gamesList = Provider.of<GamesLibrary>(context, listen: false).games.map((Game game) {
      return DropdownMenuItem(
        child: Text(game.name),
        value: game.id,
      );
    }).toList();

    playersList = Provider.of<PlayersLibrary>(context, listen: false).players.map((Player player) {
      return DropdownMenuItem(
        child: Text(player.nickname),
        value: player.nickname,
      );
    }).toList();

    playerSelects.add(PlayerSelect(
      key: UniqueKey(),
      listIndex: 0,
      playerList: playersList,)
    );
  }

  List gamesList;
  List playersList;
  List<Widget> playerSelects = [];

  int _selectedGame;
  List<Map<String, bool>> _selectedPlayers = [];

  bool _canAddPlayer() {
    return playerSelects.length == _selectedPlayers.length;
  }

  List<DropdownMenuItem<String>> _filterPlayersList() {
    final List<String> usedPlayers = _selectedPlayers.map((player) {
      return player.keys.first;
    }).toList();

    final List<DropdownMenuItem<String>> filteredPlayers = List.from(playersList)
      ..removeWhere((player) {
        return usedPlayers.contains(player.value);
      });

    return filteredPlayers;
  }

  @override
  Widget build(BuildContext context) {
    return _AddMatchData(
      data: this,
      child: Scaffold(
        appBar: AppBar(
          title: Text("New Match"),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            switch(index) {
              case 0: {
                Navigator.pop(context);
              }
              return;
              case 1: {

              }
              return;
            }
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.cancel),
              title: Text('Cancel'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              title: Text('Save'),
            ),
          ],
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.green,
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _matchFormKey,
            child: ListView(
              children: <Widget>[
                DropdownButton(
                  hint: Text('Select Game'),
                  items: gamesList,
                  value: _selectedGame,
                  onChanged: (int gameId) {
                    setState(() {
                      _selectedGame = gameId;
                    });
                  },
                  isExpanded: true,
                ),
                ListBody(
                  children: playerSelects,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        child: Icon(
                          Icons.add,
                          color: (_canAddPlayer() ? Colors.green : Colors.grey),
                        ),
                        onTap: (){
                          if (_canAddPlayer()){
                            final filteredPlayers = _filterPlayersList();
                            final playerSelect = PlayerSelect(
                              key: UniqueKey(),
                              listIndex: playerSelects.length,
                              playerList: filteredPlayers,
                            );

                            setState(() {
                              playerSelects.add(playerSelect);
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(padding: EdgeInsets.all(0.0),),
                    ),
                    Expanded(
                      child: Padding(padding: EdgeInsets.all(0.0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayerSelect extends StatefulWidget {
  PlayerSelect({
    Key key,
    this.listIndex,
    this.playerList,
  }) : super(key: key);

  final int listIndex;
  final List playerList;

  @override
  _PlayerSelectState createState() => _PlayerSelectState();
}

class _PlayerSelectState extends State<PlayerSelect> {
  String _selectedPlayer;
  bool _winner = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            child: Icon(
              Icons.remove,
              color: (widget.listIndex == 0 ? Colors.grey : Colors.red),
            ),
            onTap: () {
              final _AddMatchScreenState state = AddMatchScreen.of(context);
              state.setState(() {
                if (state._selectedPlayers.length > widget.listIndex) {
                  state._selectedPlayers.removeAt(widget.listIndex);
                }
                state.playerSelects.removeAt(widget.listIndex);
              });
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: DropdownButton(
            hint: Text('Player'),
            items: widget.playerList,
            value: _selectedPlayer,
            onChanged: (String player) {
              final _AddMatchScreenState state = AddMatchScreen.of(context);
              final Map<String, bool> selectedPlayer = {}
                ..update(player, (_) => _winner, ifAbsent: () => _winner);

              setState(() {
                _selectedPlayer = player;
              });

              state.setState(() {
                if (state._selectedPlayers.length > widget.listIndex) {
                  state._selectedPlayers.removeAt(widget.listIndex);
                }
                state._selectedPlayers.insert(widget.listIndex, selectedPlayer);
              });
            },
            isExpanded: true,
          ),
        ),
        Expanded(
          child: Switch(
            value: _winner,
            onChanged: _selectedPlayer == null ? null : (bool winner) {
              final _AddMatchScreenState state = AddMatchScreen.of(context);
              final Map<String, bool> selectedPlayer = {}
                ..update(_selectedPlayer, (_) => winner, ifAbsent: () => winner);

              setState(() {
                _winner = winner;
              });

              state.setState(() {
                if (state._selectedPlayers.length > widget.listIndex) {
                  state._selectedPlayers.removeAt(widget.listIndex);
                }
                state._selectedPlayers.insert(widget.listIndex, selectedPlayer);
              });
            },
          ),
        )
      ],
    );
  }
}