import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // dark theme
  static const Color darkBackgroundColor = Color.fromRGBO(6, 10, 27, 1);
  static const Color grey = Color.fromRGBO(45, 46, 50, 1.0);
  static const Color dialog = Color.fromRGBO(33, 31, 38, 1.0);

  // notes background color
  static const Color color1 = Color.fromRGBO(253, 137, 122, 1.0);
  static const Color color2 = Color.fromRGBO(252, 210, 128, 1.0);
  static const Color color3 = Color.fromRGBO(255, 255, 141, 1.0);
  static const Color color4 = Color.fromRGBO(207, 255, 135, 1.0);
  static const Color color5 = Color.fromRGBO(170, 255, 232, 1.0);
  static const Color color6 = Color.fromRGBO(171, 126, 243, 1.0);

  static const List<Color> palette = [
    color1,
    color2,
    color3,
    color4,
    color5,
    color6,
  ];
}

// Color color1 = Color.fromRGBO(253, 137, 122, 1.0);
// String colorstr = color1.value.toString();
// int value = int.parse(colorstr);
// Color(value)
