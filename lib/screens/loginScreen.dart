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
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Login form identifier key
  final _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocusNode = FocusNode();

  // Create a text controller and use it to retrieve the current value
  // of the TextFields.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final TextStyle style = TextStyle(fontSize: 20.0);

  // state variable for validation
  bool _autoValidate = false;

  // state variables to handle password ui display
  bool _obscurePassword = true;
  bool _focusPassword = false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(() {
      setState(() {
        _focusPassword = _passwordFocusNode.hasFocus;
        _obscurePassword = _passwordFocusNode.hasFocus ? _obscurePassword : true;
      });
    });
  }

  @override
  void dispose() {
    // Clean up focus node when widget is disposed.
    _passwordFocusNode.dispose();

    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 155.0,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 45.0),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        style: style,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: "Email",
                        ),
                        autovalidate: _autoValidate,
                        validator: (value) {
                          final Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          final RegExp regex = new RegExp(pattern);

                          if (value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!regex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        style: style,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() { _obscurePassword = !_obscurePassword; });
                            },
                            child: Visibility(
                              visible: _focusPassword,
                              child: _obscurePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                            ),
                          ),
                        ),
                        focusNode: _passwordFocusNode,
                        autovalidate: _autoValidate,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          }

                          return null;
                        },
                      ),
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
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
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
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
