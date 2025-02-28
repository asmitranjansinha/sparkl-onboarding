import 'package:flutter/material.dart';
import 'package:sprkl_onboarding/core/config/app_colors.dart';
import 'package:sprkl_onboarding/core/utils/sizer.dart';

class AppTheme {
  ThemeData appTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true, // Enable Material 3
      colorScheme: ColorScheme.light(
        primary: AppColors.yellow,
        surface: AppColors.lightYellow,
        onSurface: AppColors.black,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 30.0.sp(context),
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          fontSize: 18.0.sp(context),
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w300,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellow,
          foregroundColor: AppColors.black,
          textStyle: TextStyle(
            fontSize: 15.0.sp(context),
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          padding: EdgeInsets.symmetric(
            vertical: 15.0,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.yellow,
        foregroundColor: Colors.white,
      ),
    );
  }
}
