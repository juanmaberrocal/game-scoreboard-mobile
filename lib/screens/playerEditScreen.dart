// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/helpers/colorSelector.dart';
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/widgets/playerForm.dart';

/*
Screen: PlayerEdit
*/
class PlayerEditScreen extends StatefulWidget {
  PlayerEditScreen({
    Key key,
    @required this.player,
    this.pageTitle,
    this.successCallback,
  }) : super(key: key);

  final Player player;
  final String pageTitle;
  final Function successCallback;

  @override
  _PlayerEditScreenState createState() => _PlayerEditScreenState();
}

class _PlayerEditScreenState extends State<PlayerEditScreen> {
  // Login form identifier key
  final _playerFormKey = GlobalKey<FormState>();

  // Create a text controller and use it to retrieve the current value
  // of the TextFields.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final nicknameController = TextEditingController();

  int playerId;

  Player player;
  bool _autoValidate = false;

  void _updatePlayer() {
    setState(() {
      player = Player(
        id: playerId,
        firstName: nameController.text.split(' ').first,
        lastName: nameController.text.split(' ').last,
        email: emailController.text,
        nickname: nicknameController.text,
      );
    });
  }

  void _submitForm(BuildContext context) {
    if (_playerFormKey.currentState.validate()) {
      player.update().then((response) {
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
    player = widget.player;
    playerId = widget.player.id;

    nameController.text = "${player.firstName} ${player.lastName}";
    emailController.text = "${player.email}";
    nicknameController.text = "${player.nickname}";

    super.initState();

    nameController.addListener(_updatePlayer);
    nicknameController.addListener(_updatePlayer);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    nicknameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle ?? widget.player.nickname),
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
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
                      child: PlayerForm(
                        formKey: _playerFormKey,
                        nameInputController: nameController,
                        emailInputController: emailController,
                        nicknameInputController: nicknameController,
                        autoValidate: _autoValidate,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: _PlayerAvatar(
                    firstName: player.firstName,
                    lastName: player.lastName,
                    nickname: player.nickname,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  _PlayerAvatar({
    Key key,
    this.firstName,
    this.lastName,
    this.nickname,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final String nickname;

  @override
  Widget build(BuildContext context) {
    final firstInitial = firstName.isEmpty ? '' : firstName[0];
    final lastInitial = lastName.isEmpty ? '' : lastName[0];

    return CircleAvatar(
      radius: 50.0,
      backgroundColor: ColorSelector().fromString(nickname),
      child: (
          Text("$firstInitial$lastInitial")
      ),
    );
  }
}