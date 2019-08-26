// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:provider/provider.dart';
// app
import 'package:game_scoreboard/models/appProviders/currentPlayer.dart';
import 'package:game_scoreboard/models/appProviders/gamesLibrary.dart';
import 'package:game_scoreboard/models/appProviders/playersLibrary.dart';

/*
Screen: Login
*/
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() =>  _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create a text controller and use it to retrieve the current value
  // of the TextFields.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final TextStyle style = TextStyle(fontSize: 20.0);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.red,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
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
        },
        child: Text("Login",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/images/game-die_1f3b2.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 45.0
                ),
                emailField,
                SizedBox(
                  height: 25.0
                ),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
