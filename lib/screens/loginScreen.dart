// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/appProviders/playersLibrary.dart';
import 'package:game_scoreboard/widgets/loginForm.dart';
import 'package:game_scoreboard/widgets/logo.dart';

/*
Screen: Login
*/
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Login form identifier key
  final _loginFormKey = GlobalKey<FormState>();

  // Create a text controller and use it to retrieve the current value
  // of the TextFields.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final TextStyle style = TextStyle(fontSize: 20.0);

  // state variable for validation
  bool _autoValidate = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void _onLogin() {
    if (_loginFormKey.currentState.validate()) {
      Provider.of<CurrentPlayer>(context, listen: false).logIn(
        emailController.text,
        passwordController.text,
      ).then((void _) {
        // if sign in successful load necessary data
        // and navigate to dashboard
        Provider.of<GamesLibrary>(context, listen: false).load().then((void _) {
          Provider.of<PlayersLibrary>(context, listen: false).load().then((void _) {
            Navigator.of(context).pushReplacementNamed('/dashboard');
          });
        });
      }).catchError((err) {
        // if sign in failed display error message
        final String errorString = err.toString();
        final String errorMessage = errorString.replaceAll('Exception: ', '');

        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Could Not Sign In Player:\n$errorMessage'),
            );
          },
        );
      });
    } else {
      setState(() => _autoValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(vertical: 18.0, horizontal: 36.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Logo(maxHeight: 100.0,),
                LoginForm(
                  formKey: _loginFormKey,
                  emailInputController: emailController,
                  passwordInputController: passwordController,
                  autoValidate: _autoValidate,
                ),
                Container(
                  margin: EdgeInsets.only(top: 35.0),
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    color: Colors.red,
                    child: Text("Login",
                        textAlign: TextAlign.center,
                        style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
                    ),
                    onPressed: _onLogin,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
