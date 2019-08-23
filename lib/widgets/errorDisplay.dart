// flutter
import 'package:flutter/material.dart';
// dependencies
// app

/*
Widget: ErrorDisplay
*/
Widget ErrorDisplay(BuildContext context, String errorMessage) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LayoutBuilder(builder: (context, constraint) {
          return Icon(Icons.error_outline, size: constraint.biggest.width/2);
        }),
        Text(errorMessage),
      ],
    ),
  );
}
