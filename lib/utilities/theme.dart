import 'package:flutter/material.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';

@immutable
class AppTheme {
  static Locale fallbackLocale = const Locale('en', 'US');

  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.green,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColorDark: Colors.lightGreen,
  );

  static Color backgroundColor() {
    return AppStateController.useDarkMode.value
        ? AppColors.bgColorDarkMode
        : AppColors.bgColorLightMode;
  }

  static Color accentColor =
      AppStateController.useDarkMode.value
          ? AppColors.green
          : AppColors.limeGreen;

  static Color textColor() {
    return AppStateController.useDarkMode.value
        ? AppColors.textColorDarkMode
        : AppColors.textColorLightMode;
  }

  static Color secondaryTextColor =
      AppStateController.useDarkMode.value
          ? AppColors.green
          : AppColors.limeGreen;
}

@immutable
class AppStyles {
  // TODO(RV): Add styles for text, buttons, etc.
}

@immutable
class AppColors {
  static const Color textColorLightMode = darkGrey;
  static const Color textColorDarkMode = white;
  static const Color bgColorLightMode = white;
  static const Color bgColorDarkMode = darkGrey;

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color limeGreen = Color(0xFF00FF00);
  static const Color green = Color(0xFF005500);
  static const Color darkGreen = Color(0xFF002200);
  static const Color lightBlue = Color(0xFF2196F3);
  static const Color blue = Color(0xFF0000FF);
  static const Color red = Color(0xFFFF0000);
  static const Color grey = Color(0xFF808080);
  static const Color lightGrey = Color(0xFFDDDDDD);
  static const Color darkGrey = Color(0xFF181818);
  static const Color lavender = Color(0xFFD0BCFF);
}
