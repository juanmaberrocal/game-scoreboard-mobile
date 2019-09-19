import 'package:flutter/material.dart';

/*
Widget: LoginForm
Build login form with email and password inputs

GlobalKey<FormState> formKey: [required]
TextEditingController emailInputController: [required]
TextEditingController passwordInputController: [required]
bool autoValidate:
 */
class LoginForm extends StatelessWidget {
  LoginForm({
    Key key,
    @required this.formKey,
    @required this.emailInputController,
    @required this.passwordInputController,
    this.autoValidate = false,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController emailInputController;
  final TextEditingController passwordInputController;
  final bool autoValidate;

  static const TextStyle style = TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 45.0),
            child: _EmailInput(
              controller: emailInputController,
              autoValidate: autoValidate,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25.0),
            child: _PasswordInput(
              controller: passwordInputController,
              autoValidate: autoValidate,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  _EmailInput({
    Key key,
    @required this.controller,
    this.autoValidate = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool autoValidate;

  static const Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: LoginForm.style,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: 'Email',
      ),
      autovalidate: autoValidate,
      validator: (value) {
        final RegExp regex = new RegExp(pattern);

        if (value.isEmpty) {
          return 'Please enter your email';
        } else if (!regex.hasMatch(value)) {
          return 'Please enter a valid email';
        }

        return null;
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  _PasswordInput({
    Key key,
    @required this.controller,
    this.autoValidate = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool autoValidate;

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
        _obscure = _focusNode.hasFocus ? _obscure : true;
      });
    });
  }

  @override
  void dispose() {
    // Clean up focus node when widget is disposed.
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      style: LoginForm.style,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        labelText: 'Password',
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() { _obscure = !_obscure; });
          },
          child: Visibility(
            visible: _hasFocus,
            child: _obscure ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
          ),
        ),
      ),
      focusNode: _focusNode,
      autovalidate: widget.autoValidate,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your password';
        }

        return null;
      },
    );
  }
}