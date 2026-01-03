import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      headlineSmall: AppTextStyles.headline,
      titleMedium: AppTextStyles.sectionTitle,
      bodyMedium: AppTextStyles.body,
      labelLarge: AppTextStyles.button,
      bodySmall: AppTextStyles.caption,
    ),
  );
}
