// flutter
import 'package:flutter/material.dart';
// dependencies
// app
import 'package:game_scoreboard/widgets/appFormInputs.dart';

class GameForm extends StatelessWidget {
  GameForm({
    Key key,
    @required this.formKey,
    @required this.nameInputController,
    @required this.descriptionController,
    @required this.minPlayersController,
    @required this.maxPlayersController,
    @required this.minPlayTimeController,
    @required this.maxPlayTimeController,
    this.autoValidate = false,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController nameInputController;
  final TextEditingController descriptionController;
  final TextEditingController minPlayersController;
  final TextEditingController maxPlayersController;
  final TextEditingController minPlayTimeController;
  final TextEditingController maxPlayTimeController;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          _NameInput(
            controller: nameInputController,
            autoValidate: autoValidate,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _MinPlayersInput(
                        controller: minPlayersController,
                        autoValidate: autoValidate,
                      ),
                    ),
                    Expanded(
                      child: _MaxPlayersInput(
                        controller: maxPlayersController,
                        autoValidate: autoValidate,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _MinPlayTimeInput(
                        controller: minPlayTimeController,
                        autoValidate: autoValidate,
                      ),
                    ),
                    Expanded(
                      child: _MaxPlayTimeInput(
                        controller: maxPlayTimeController,
                        autoValidate: autoValidate,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _DescriptionInput(
            controller: descriptionController,
            autoValidate: autoValidate,
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
      align: TextAlign.center,
      isRequired: true,
      autoValidate: autoValidate,
    );
  }
}

class _MinPlayersInput extends StatelessWidget {
  _MinPlayersInput({
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
      label: 'Min Players',
      inputType: TextInputType.number,
      align: TextAlign.center,
      isRequired: false,
      autoValidate: autoValidate,
    );
  }
}

class _MaxPlayersInput extends StatelessWidget {
  _MaxPlayersInput({
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
      label: 'Max Players',
      inputType: TextInputType.number,
      align: TextAlign.center,
      isRequired: false,
      autoValidate: autoValidate,
    );
  }
}

class _MinPlayTimeInput extends StatelessWidget {
  _MinPlayTimeInput({
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
      label: 'Min Time',
      inputType: TextInputType.number,
      align: TextAlign.center,
      isRequired: false,
      autoValidate: autoValidate,
    );
  }
}

class _MaxPlayTimeInput extends StatelessWidget {
  _MaxPlayTimeInput({
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
      label: 'Max Time',
      inputType: TextInputType.number,
      align: TextAlign.center,
      isRequired: false,
      autoValidate: autoValidate,
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  _DescriptionInput({
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
      label: 'Description',
      isRequired: false,
      multiLine: true,
      autoValidate: autoValidate,
    );
  }
}