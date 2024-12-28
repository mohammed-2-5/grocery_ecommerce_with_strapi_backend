import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Light Theme Colors
  static Color lightBackgroundColor = const Color(0xfff2f2f2);
  static Color lightPrimaryColor = const Color(0xffff8900);
  static Color lightSecondaryColor = const Color(0xff040415);
  static Color lightAccentColor = Colors.blueGrey.shade200;
  static Color lightParticlesColor = const Color(0x44948282);
  static Color lightTextColor = Colors.black54;

  // Dark Theme Colors
  static Color darkBackgroundColor = const Color(0xff1e1e1e);
  static Color darkPrimaryColor = const Color(0xffbb86fc);
  static Color darkSecondaryColor = const Color(0xff03dac6);
  static Color darkAccentColor = Colors.tealAccent.shade200;
  static Color darkParticlesColor = const Color(0x442c2c2e);
  static Color darkTextColor = Colors.white70;

  const AppTheme._();

  // Light Theme Configuration
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(backgroundColor: lightPrimaryColor),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: lightBackgroundColor),
    ),
    colorScheme: ColorScheme.light(secondary: lightSecondaryColor)
        .copyWith(surface: lightBackgroundColor),
  );

  // Dark Theme Configuration
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(backgroundColor: darkPrimaryColor),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: darkBackgroundColor),
    ),
    colorScheme: ColorScheme.dark(secondary: darkSecondaryColor)
        .copyWith(surface: darkBackgroundColor),
  );

  // Get the current system brightness
  static Brightness get currentSystemBrightness =>
      PlatformDispatcher.instance.platformBrightness;

  // Set system colors based on theme mode
  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: darkBackgroundColor,
        systemNavigationBarDividerColor: Colors.transparent,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: lightBackgroundColor,
        systemNavigationBarDividerColor: Colors.transparent,
      ));
    }
  }
}
