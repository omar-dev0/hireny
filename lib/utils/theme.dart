import 'package:flutter/material.dart';
import 'package:hireny/utils/app_colors.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      onPrimaryContainer: AppColors.textInputBorder,
      secondary: AppColors.subPrimary,
      onSecondary: AppColors.white,
    ),
  );
}
