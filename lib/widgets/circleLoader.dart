// flutter
import 'package:flutter/material.dart';
// dependencies
// app

/*
Widget: CircleLoader
Builds a CircularProgressIndicator (infinite)
  centered in a box of a specified size.

double height: pixel height to cover [default = 30.0]
double width: pixel width to cover [default = 30.0]
 */
class CircleLoader extends StatelessWidget {
  CircleLoader({
    Key key,
    this.height = 30.0,
    this.width = 30.0,
  })  : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: CircularProgressIndicator()
      ),
    );
  }
}

/*
Widget: SliverCircleLoader
Simple wrapper sliver widget for the original CircleLoader
  (Check above)

double height: pixel height to cover [default = 30.0]
double width: pixel width to cover [default = 30.0]
 */
class SliverCircleLoader extends StatelessWidget {
  SliverCircleLoader({
    Key key,
    this.height = 30.0,
    this.width = 30.0,
  })  : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CircleLoader(
        width: width,
        height: height,
      )
    );
  }
}