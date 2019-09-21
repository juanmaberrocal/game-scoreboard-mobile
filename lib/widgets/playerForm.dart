// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/widgets/appFormInputs.dart';

class PlayerForm extends StatelessWidget {
  PlayerForm({
    Key key,
    @required this.formKey,
    @required this.nameInputController,
    @required this.emailInputController,
    @required this.nicknameInputController,
    this.autoValidate = false,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController nameInputController;
  final TextEditingController emailInputController;
  final TextEditingController nicknameInputController;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              width: constraints.maxWidth * 0.75,
              child: Column(
                children: <Widget>[
                  _NameInput(
                      controller: nameInputController,
                      autoValidate: autoValidate
                  ),
                  _EmailInput(
                    controller: emailInputController,
                    autoValidate: autoValidate,
                  ),
                ],
              ),
            );
          }),
          Padding(padding: EdgeInsets.all(18.0),),
          _NicknameInput(
              controller: nicknameInputController,
              autoValidate: autoValidate
          ),
        ],
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  _NameInput({
    Key key,
    @required this.controller,
    this.autoValidate = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    return VerticalInput(
      controller: controller,
      label: 'Name',
      isRequired: true,
      autoValidate: autoValidate,
      validator: (String value) {
        final Pattern pattern = r'^(\w+)\s+(\w+)$';
        final RegExp regex = new RegExp(pattern);

        if (value.isEmpty) {
          return 'Please enter your name';
        } else if (!regex.hasMatch(value)) {
          return 'Please enter your first name AND last name';
        }

        return null;
      },
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

  @override
  Widget build(BuildContext context) {
    return VerticalInput(
      controller: controller,
      label: 'Email',
      isEnabled: false,
      isRequired: true,
      autoValidate: autoValidate,
    );
  }
}

class _NicknameInput extends StatelessWidget {
  _NicknameInput({
    Key key,
    @required this.controller,
    this.autoValidate = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    return HorizontalInput(
      controller: controller,
      label: 'Nickname',
      isRequired: true,
      autoValidate: autoValidate,
    );
  }
}
