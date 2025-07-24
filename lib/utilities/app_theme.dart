import 'package:flutter/material.dart';
import 'constants.dart';

/// 全局主题配置类
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      surface: AppColors.lightBackground,
      primary: AppColors.primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      titleTextStyle: TextStyle(color: AppColors.lightAppBarTitle, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: AppColors.lightAppBarIcon),
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightText, fontSize: kBodyLargeFontSize),
      bodyMedium: TextStyle(color: AppColors.lightText, fontSize: kBodyMediumFontSize),
      bodySmall: TextStyle(color: AppColors.lightText, fontSize: kBodySmallFontSize),
    ),
    iconTheme: const IconThemeData(color: AppColors.lightIcon),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightButtonBackground,
        foregroundColor: AppColors.lightText,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.lightIconActive),
    ),
    useMaterial3: true,
    shadowColor: AppColors.lightShadow,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.darkSurface,
      primary: AppColors.primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      titleTextStyle: TextStyle(color: AppColors.darkAppBarTitle, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: AppColors.darkAppBarIcon),
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText, fontSize: kBodyLargeFontSize),
      bodyMedium: TextStyle(color: AppColors.darkText, fontSize: kBodyMediumFontSize),
      bodySmall: TextStyle(color: AppColors.darkText, fontSize: kBodySmallFontSize),
    ),
    iconTheme: const IconThemeData(color: AppColors.darkIcon),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkButtonBackground,
        foregroundColor: AppColors.darkText,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.darkIconActive),
    ),
    useMaterial3: true,
    shadowColor: AppColors.lightShadow.withAlpha(0),
  );
} 