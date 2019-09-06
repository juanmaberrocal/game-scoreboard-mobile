// flutter
import 'package:flutter/material.dart';
// dependencies
// app

/*
Widget: ErrorDisplay
Builds an error_outline Icon of a specified width
  with an error message below it
  centered in a box.

String errorMessage: message to display
double size: pixel size to cover [defaults to half the container width]
 */
class ErrorDisplay extends StatelessWidget {
  ErrorDisplay({
    Key key,
    this.errorMessage,
    this.size,
  }) : super(key: key);

  final String errorMessage;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(builder: (context, constraint) {
            final iconSize = size == null ?
              constraint.biggest.width/2 :
              size;

            return Icon(Icons.error_outline, size: iconSize);
          }),
          Text(errorMessage),
        ],
      ),
    );
  }
}

/*
Widget: SliverErrorDisplay
Simple wrapper sliver widget for the original ErrorDisplay
  (Check above)

String errorMessage: message to display
double size: pixel size to cover [defaults to half the container width]
 */
class SliverErrorDisplay extends StatelessWidget {
  SliverErrorDisplay({
    Key key,
    this.errorMessage,
    this.size,
  }) : super(key: key);

  final String errorMessage;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ErrorDisplay(
        errorMessage: errorMessage,
        size: size,
      )
    );
  }
}