import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  double dynamicHeight(double value) => screenHeight * value;
  double dynamicWidth(double value) => screenWidth * value;
}
