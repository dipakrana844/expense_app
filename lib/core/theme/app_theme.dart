import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/core/constants/app_colors.dart';
import 'package:smart_expense_tracker/core/constants/app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.seed,
        brightness: brightness,
        secondary: AppColors.secondary,
        surface: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      ),
      textTheme: AppTextStyles.buildTextTheme(baseTheme.textTheme),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      // Fix: Some Flutter versions require CardThemeData within cardTheme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: isDark ? AppColors.darkCard : Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? Colors.white10
            : Colors.black.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
