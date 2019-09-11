// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// dependencies
// app

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
    return _VerticalInput(
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
    return _VerticalInput(
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
    return _HorizontalInput(
      controller: controller,
      label: 'Nickname',
      isRequired: true,
      autoValidate: autoValidate,
    );
  }
}

class _VerticalInput extends StatelessWidget {
  _VerticalInput({
    Key key,
    @required this.controller,
    @required this.label,
    this.align = TextAlign.center,
    this.isEnabled = true,
    this.isRequired = false,
    this.autoValidate = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final TextAlign align;
  final bool isEnabled;
  final bool isRequired;
  final bool autoValidate;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "$label${isRequired ? " *" : ""}",
        enabled: isEnabled,
      ),
      style: TextStyle(
        color: (
            isEnabled ?
            Theme.of(context).textTheme.caption.color :
            Theme.of(context).disabledColor
        ),
      ),
      textAlign: align,
      enabled: isEnabled,
      autovalidate: autoValidate,
      validator: (
          validator != null ?
          validator :
          isRequired ?
              (String value) => (value.isEmpty ? 'Please enter your ${label.toLowerCase()}' : null) :
          null
      ),
    );
  }
}
class _HorizontalInput extends StatefulWidget {
  _HorizontalInput({
    Key key,
    @required this.controller,
    @required this.label,
    this.align = TextAlign.center,
    this.isEnabled = true,
    this.isRequired = false,
    this.autoValidate = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final TextAlign align;
  final bool isEnabled;
  final bool isRequired;
  final bool autoValidate;
  final Function validator;

  @override
  _HorizontalInputState createState() => _HorizontalInputState();
}

class _HorizontalInputState extends State<_HorizontalInput> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
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
      focusNode: _focusNode,
      decoration: InputDecoration(
        enabled: widget.isEnabled,
        prefixText: "${widget.label}${widget.isRequired ? " *" : ""}",
        prefixStyle: TextStyle(
          color: (
              widget.isEnabled ?
              (
                  _hasFocus ?
                  Theme.of(context).accentColor :
                  Theme.of(context).textTheme.caption.color
              ) :
              Theme.of(context).disabledColor
          ),
        ),
      ),
      style: TextStyle(
        color: (
            widget.isEnabled ?
            Theme.of(context).textTheme.caption.color :
            Theme.of(context).disabledColor
        ),
      ),
      textAlign: widget.align,
      enabled: widget.isEnabled,
      autovalidate: widget.autoValidate,
      validator: (
        widget.validator != null ?
        widget.validator :
        widget.isRequired ?
            (String value) => (value.isEmpty ? 'Please enter your ${widget.label.toLowerCase()}' : null) :
        null
      ),
    );
  }
}