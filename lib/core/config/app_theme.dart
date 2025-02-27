import 'package:flutter/material.dart';
import 'package:sprkl_onboarding/core/config/app_colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    useMaterial3: true, // Enable Material 3
    colorScheme: ColorScheme.light(
      primary: AppColors.yellow,
      surface: AppColors.lightYellow,
      onSurface: AppColors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.yellow,
      foregroundColor: Colors.white,
    ),
  );
}
