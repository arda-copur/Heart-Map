import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  final Color appBlack = Colors.black;
  final Color appWhite = Colors.white;
  final Color appCorrectAnswer = Colors.green.withOpacity(0.8);
  final Color appWrongAnswer = Colors.red.withOpacity(0.8);

  static ColorScheme appColorSheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff6d5e0f),
    surfaceTint: Color(0xff6d5e0f),
    background: Color(0xffffffff),
    onBackground: Color(0xffcdc6b4),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xfff8e287),
    onPrimaryContainer: Color(0xff534600),
    secondary: Color(0xff805610),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffffddb3),
    onSecondaryContainer: Color(0xff633f00),
    tertiary: Color(0xff43664e),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xffc5ecce),
    onTertiaryContainer: Color(0xff2c4e38),
    error: Color(0xffba1a1a),
    onError: Color(0xffffffff),
    errorContainer: Color(0xffffdad6),
    onErrorContainer: Color(0xff93000a),
    surface: Color(0xfffff9ee),
    onSurface: Color(0xff1e1b13),
    onSurfaceVariant: Color(0xff4b4739),
    outline: Color(0xff7c7767),
    outlineVariant: Color(0xffcdc6b4),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff333027),
    inversePrimary: Color(0xffdbc66e),
  );

  //Paddings

  /// [minPadding] is 4
  static const EdgeInsets minPadding = EdgeInsets.all(4);

  /// [smallPadding] is 8
  static const EdgeInsets smallPadding = EdgeInsets.all(8);

  /// [primaryPadding] is 12
  static const EdgeInsets primaryPadding = EdgeInsets.all(12);

  /// [highPadding] is 16
  static const EdgeInsets highPadding = EdgeInsets.all(16);

  /// [extraPadding] is 20
  static const EdgeInsets extraPadding = EdgeInsets.all(20);

  /// [topMinPadding] is 8
  static const EdgeInsets topMinPadding = EdgeInsets.only(top: 8);

  /// [topSmallPadding] is 10
  static const EdgeInsets topSmallPadding = EdgeInsets.only(top: 10);

  /// [topPrimaryPadding] is 12
  static const EdgeInsets topPrimaryPadding = EdgeInsets.only(top: 12);

  //Border Radius

  /// [smallCircular] is 4
  static final BorderRadius smallCircular = BorderRadius.circular(4);

  /// [primaryCircular] is 8
  static final BorderRadius primaryCircular = BorderRadius.circular(8);

  /// [extraCircular] is 12
  static final BorderRadius extraCircular = BorderRadius.circular(12);

  /// [hugeCircular] is 20
  static final BorderRadius hugeCircular = BorderRadius.circular(20);

  // Temayı güncelle
  static final ThemeData appTheme = ThemeData(
    colorScheme: appColorSheme, // Yeni renk paletini burada kullan
    primaryColor: appColorSheme.primary,
    scaffoldBackgroundColor: appColorSheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: appColorSheme.onPrimaryContainer,
      foregroundColor: appColorSheme.onSurface,
    ),
    cardTheme: CardTheme(
      color: appColorSheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: appColorSheme.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontFamily: 'Kanit',
        color: appColorSheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Kanit',
        color: appColorSheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Kanit',
        color: appColorSheme.surface,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Kanit',
        color: appColorSheme.onPrimaryContainer,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Kanit',
        color: appColorSheme.onPrimaryContainer,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Kanit',
        fontWeight: FontWeight.bold,
        color: appColorSheme.onPrimaryContainer,
      ),
    ),
  );
}
