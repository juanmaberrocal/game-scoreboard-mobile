import 'package:flutter/material.dart';

/*
Widget: Logo
Builds a container and displays the apps logo image.
  The size of the container can be controlled with fixed numbers
  or you can define ratio constraints.

double maxHeight:
double maxWidth:
double heightRatio:
double widthRatio:
double aspectRatio:
 */
class Logo extends StatelessWidget {
  Logo({
    Key key,
    this.maxHeight = double.infinity,
    this.maxWidth = double.infinity,
    this.heightRatio,
    this.widthRatio,
    this.aspectRatio,
  }) : super(key: key);

  static const image = 'assets/images/logo.png';

  final double maxHeight;
  final double maxWidth;

  final double heightRatio;
  final double widthRatio;

  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (aspectRatio == null) {
      final height = heightRatio == null ? maxHeight : MediaQuery.of(context).size.height / heightRatio;
      final width = widthRatio == null ? maxWidth : MediaQuery.of(context).size.width / widthRatio;

      widget = _SizedLogo(height: height, width: width,);
    } else {
      widget = _RatioLogo(aspectRatio: aspectRatio,);
    }

    return widget;
  }
}

class _SizedLogo extends StatelessWidget {
  _SizedLogo({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Logo.image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _RatioLogo extends StatelessWidget {
  _RatioLogo({
    Key key,
    @required this.aspectRatio,
  }) : super(key: key);

  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Image.asset(Logo.image),
    );
  }
}