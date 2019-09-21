// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/models/game.dart';
import 'package:game_scoreboard/widgets/gameAvatar.dart';
import 'package:game_scoreboard/widgets/gameForm.dart';

/*
Screen: GameEdit
*/
class GameEditScreen extends StatefulWidget {
  GameEditScreen({
    Key key,
    @required this.game,
    this.pageTitle,
    this.successCallback,
  }) : super(key: key);

  final Game game;
  final String pageTitle;
  final Function successCallback;

  @override
  _GameEditScreenState createState() => _GameEditScreenState();
}

class _GameEditScreenState extends State<GameEditScreen> {
  // Player form identifier key
  final _gameFormKey = GlobalKey<FormState>();

  // Create a text controller and use it to retrieve the current value
  // of the TextFields.
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final minPlayersController = TextEditingController();
  final maxPlayersController = TextEditingController();
  final minPlayTimeController = TextEditingController();
  final maxPlayTimeController = TextEditingController();

  int gameId;
  String gameAvatar;

  Game game;
  bool _autoValidate = false;

  void _updateGame() {
    setState(() {
      game = Game(
        id: gameId,
        avatarUrl: gameAvatar,
        name: nameController.text,
        description: descriptionController.text,
        minPlayers: int.tryParse(minPlayersController.text) ?? 0,
        maxPlayers: int.tryParse(maxPlayersController.text) ?? 0,
        minPlayTime: int.tryParse(minPlayTimeController.text) ?? 0,
        maxPlayTime: int.tryParse(maxPlayTimeController.text) ?? 0,
      );
    });
  }

  void _submitForm(BuildContext context) {
    if (_gameFormKey.currentState.validate()) {
      game.update().then((response) {
        if (widget.successCallback != null) {
          widget.successCallback(response);
        }

        Navigator.pop(context);
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  void initState() {
    game = widget.game;
    gameId = widget.game.id;
    gameAvatar = widget.game.avatarUrl;

    nameController.text = "${game.name}";
    descriptionController.text = "${game.description}";
    minPlayersController.text = "${game.minPlayers}";
    maxPlayersController.text = "${game.maxPlayers}";
    minPlayTimeController.text = "${game.minPlayTime}";
    maxPlayTimeController.text = "${game.maxPlayTime}";

    super.initState();

    nameController.addListener(_updateGame);
    descriptionController.addListener(_updateGame);
    minPlayersController.addListener(_updateGame);
    maxPlayersController.addListener(_updateGame);
    minPlayTimeController.addListener(_updateGame);
    maxPlayTimeController.addListener(_updateGame);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    descriptionController.dispose();
    minPlayersController.dispose();
    maxPlayersController.dispose();
    minPlayTimeController.dispose();
    maxPlayTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle ?? widget.game.name),
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
              _submitForm(context);
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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  GameAvatar(
                    game: game,
                    height: MediaQuery.of(context).size.height / 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: GameForm(
                      formKey: _gameFormKey,
                      nameInputController: nameController,
                      descriptionController: descriptionController,
                      minPlayersController: minPlayersController,
                      maxPlayersController: maxPlayersController,
                      minPlayTimeController: minPlayTimeController,
                      maxPlayTimeController: maxPlayTimeController,
                      autoValidate: _autoValidate,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}