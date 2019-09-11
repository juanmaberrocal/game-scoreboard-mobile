// flutter
import 'package:flutter/material.dart';

Color getColorFromString(String string) {
  Color color;

  if (string.isEmpty) {
    color = Colors.grey[200];
  } else {
    final int colorIndex = string.toLowerCase().codeUnitAt(0) - 97;
    final int colorOffset = colorIndex % 17;
    color = Colors.primaries[colorOffset];
  }

  return color;
}
