// flutter
import 'dart:async';
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/helpers/gsSnackBar.dart';
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/player.dart';
import 'package:game_scoreboard/screens/playerEditScreen.dart';
import 'package:game_scoreboard/widgets/avatarUpload.dart';
import 'package:game_scoreboard/widgets/playerCard.dart';

/*
Screen: Profile
*/
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Profile scaffold identifier key
  final _profileScaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _openChangeAvatar() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AvatarUpload(
          uploadFunction: Provider.of<CurrentPlayer>(context, listen: false).uploadAvatar,
          screenContext: context,
          screenScaffold: _profileScaffoldKey,
        );
      },
    );
  }

  void _goToProfileEdit(Player player) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerEditScreen(
          player: player,
          pageTitle: 'Edit Profile',
          successCallback: (Player _player) {
            Provider.of<CurrentPlayer>(context, listen: false).refreshCurrentPlayer(_player);
          },
        ),
      ),
    );
  }

  Future<void> _openChangePassword() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return _ChangePasswordDialog(
          screenContext: context,
          screenScaffold: _profileScaffoldKey,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentPlayer>(
      builder: (context, currentPlayer, child) {
        final Player player = currentPlayer.player;

        return Scaffold(
          key: _profileScaffoldKey,
          appBar: AppBar(
            title: Text('My Profile'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              switch(index) {
                case 0: {
                  _openChangeAvatar();
                }
                return;
                case 1: {
                  _goToProfileEdit(player);
                }
                return;
                case 2: {
                  _openChangePassword();
                }
                return;
              }
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                title: Text('Avatar'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                title: Text('Edit'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lock),
                title: Text('Password'),
              )
            ],
            fixedColor: Theme.of(context).textTheme.caption.color,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                PlayerCard(player: player,),
              ],
            ),
          ),
        ); 
      },
    );
  }
}

class _ChangePasswordDialog extends StatefulWidget {
  _ChangePasswordDialog({
    Key key,
    this.screenContext,
    this.screenScaffold,
  }) : super(key: key);

  final BuildContext screenContext;
  final GlobalKey<ScaffoldState> screenScaffold;

  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  // Change password form identifier key
  final _changePasswordFormKey = GlobalKey<FormState>();

  // Create a text controller and use it to retrieve the current value
  // of the TextFields.
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmationController = TextEditingController();

  bool _autoValidate = false;

  void _changePassword() {
    Navigator.pop(widget.screenContext);
    Provider.of<CurrentPlayer>(widget.screenContext, listen: false).changePassword(
      _currentPasswordController.text,
      _newPasswordController.text,
      _newPasswordConfirmationController.text,
    ).then((_) {
      GSSnackBar(screenScaffold: widget.screenScaffold.currentState)
        ..success('Password changed!',);
    }).catchError((error) {
      GSSnackBar(screenScaffold: widget.screenScaffold.currentState)
        ..error('There was an error changing your password!',);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change Password'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Form(
              key: _changePasswordFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _currentPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Current Password *',
                    ),
                    autovalidate: _autoValidate,
                    validator: (String value) => (value.isEmpty ? 'Required' : null),
                  ),
                  Divider(),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password *',
                    ),
                    autovalidate: _autoValidate,
                    validator: (String value) => (value.isEmpty ? 'Required' : null),
                  ),
                  TextFormField(
                    controller: _newPasswordConfirmationController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password *',
                    ),
                    autovalidate: _autoValidate,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Required';
                      } else if (value != _newPasswordController.text) {
                        return 'Password Doesn\'t Match';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(widget.screenContext);
            },
            child: Text('Cancel')),
        RaisedButton(
          onPressed: () {
            if (_changePasswordFormKey.currentState.validate()) {
              _changePassword();
            } else {
              setState(() {
                _autoValidate = true;
              });
            }
          },
          child: Text('Change', style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
