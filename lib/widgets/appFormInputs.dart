// flutter
import 'package:flutter/material.dart';
// dependencies
// app

class VerticalInput extends StatelessWidget {
  VerticalInput({
    Key key,
    @required this.controller,
    @required this.label,
    this.inputType = TextInputType.text,
    this.align = TextAlign.left,
    this.isEnabled = true,
    this.isRequired = false,
    this.multiLine = false,
    this.autoValidate = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final TextAlign align;
  final bool isEnabled;
  final bool isRequired;
  final bool multiLine;
  final bool autoValidate;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "$label${isRequired ? "*" : ""}",
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
      keyboardType: multiLine ? TextInputType.multiline : inputType,
      maxLines: multiLine ? null : 1,
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
class HorizontalInput extends StatefulWidget {
  HorizontalInput({
    Key key,
    @required this.controller,
    @required this.label,
    this.inputType = TextInputType.text,
    this.align = TextAlign.left,
    this.isEnabled = true,
    this.isRequired = false,
    this.multiLine = false,
    this.autoValidate = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final TextAlign align;
  final bool isEnabled;
  final bool isRequired;
  final bool multiLine;
  final bool autoValidate;
  final Function validator;

  @override
  _HorizontalInputState createState() => _HorizontalInputState();
}

class _HorizontalInputState extends State<HorizontalInput> {
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
        prefixText: "${widget.label}${widget.isRequired ? "*" : ""}     ",
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
      keyboardType: widget.multiLine ? TextInputType.multiline : widget.inputType,
      maxLines: widget.multiLine ? null : 1,
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