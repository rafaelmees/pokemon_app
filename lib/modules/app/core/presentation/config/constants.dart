import 'package:flutter/material.dart';

class AppConstants {
  static const Radius cardBorderRadius = Radius.circular(16.0);
  static const ShapeBorder cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      cardBorderRadius,
    ),
  );

  static const Radius dialogBorderRadius = Radius.circular(16.0);
  static const ShapeBorder dialogShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      dialogBorderRadius,
    ),
  );

  static const num compactBreakpoint = 600;
  static const num mediumBreakpoint = 840;

  static const double baseSpacing = 8.0;

  static const double spacing1 = baseSpacing;
  static const double spacing2 = baseSpacing*2;
  static const double spacing3 = baseSpacing*3;
  static const double spacing4 = baseSpacing*4;
  static const double spacing5 = baseSpacing*5;
  static const double spacing6 = baseSpacing*6;
  static const double spacing7 = baseSpacing*7;
  static const double spacing8 = baseSpacing*8;
  static const double spacing9 = baseSpacing*9;
  static const double spacing10 = baseSpacing*10;
}
