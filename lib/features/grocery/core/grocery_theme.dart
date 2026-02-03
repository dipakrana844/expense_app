import 'package:flutter/material.dart';

/// Grocery Feature Theme Constants
///
/// Defines the visual identity for the Grocery feature to make it feel
/// like a first-class citizen in the app with its own distinct personality.
class GroceryTheme {
  /// Fresh green/mint accent color for grocery-related UI elements
  static const Color primaryColor = Color(0xFF4CAF50);

  /// Softer background for grocery cards to feel welcoming and familiar
  static const Color cardBackgroundColor = Color(0xFFF1F8E9);

  /// Lighter variant for subtle highlights
  static const Color lightBackgroundColor = Color(0xFFE8F5E9);

  /// Darker text for better readability on light backgrounds
  static const Color textColor = Color(0xFF1B5E20);

  /// Subtle hint color for secondary information
  static const Color hintColor = Color(0xFF4CAF50);

  /// Success color for positive actions (like adding items)
  static const Color successColor = Color(0xFF2E7D32);

  /// Warning color for caution states (like low stock suggestions)
  static const Color warningColor = Color(0xFFF57C00);

  /// Error color for destructive actions (like delete)
  static const Color errorColor = Color(0xFFD32F2F);

  /// Get themed AppBar for grocery screens
  static AppBar getAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
    );
  }

  /// Get styled card theme for grocery items
  static CardThemeData getCardTheme() {
    return CardThemeData(
      color: cardBackgroundColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
    );
  }

  /// Get elevated button theme for grocery actions
  static ElevatedButtonThemeData getButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      ),
    );
  }

  /// Get text theme adjustments for grocery screens
  static TextTheme getTextTheme(TextTheme base) {
    return base.copyWith(
      headlineSmall: base.headlineSmall?.copyWith(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: textColor,
      ),
    );
  }

  /// Get input decoration theme for grocery forms
  static InputDecorationTheme getInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: lightBackgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
      labelStyle: const TextStyle(
        color: textColor,
      ),
      prefixIconColor: primaryColor,
    );
  }
}