// flutter
import 'package:flutter/material.dart';

Color getColorFromString(String string) {
  final int colorIndex = string.toLowerCase().codeUnitAt(0) - 97;
  final int colorOffset = colorIndex % 17;
  final Color color = Colors.primaries[colorOffset];

  return color;
}
