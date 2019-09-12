// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// dependencies
// app

class GSSnackBar {
  GSSnackBar({
    @required this.screenScaffold
  });

  final ScaffoldState screenScaffold;

  void success(String successMessage) {
    final Widget successText = Row(
      children: <Widget>[
        Icon(Icons.check_circle, color: Colors.green,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
        Expanded(
          child: Text(successMessage),
        ),
      ],
    );

    final snackBar = SnackBar(
      content: successText,
    );

    _display(snackBar);
  }

  void error(String errorMessage) {
    final Widget errorText = Row(
      children: <Widget>[
        Icon(Icons.error, color: Colors.red,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
        Expanded(
          child: Text(errorMessage),
        ),
      ],
    );

    final snackBar = SnackBar(
      content: errorText,
    );

    _display(snackBar);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _display(
    SnackBar snackBar,
  ) {
    return screenScaffold.showSnackBar(snackBar);
  }
}