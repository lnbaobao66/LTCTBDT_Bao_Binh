import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Orange (Fitness Style)
  static const Color primaryOrange = Color(0xFFFF8C42);
  static const Color primaryOrangeDark = Color(0xFFE67E22);
  static const Color primaryOrangeLight = Color(0xFFFFB366);

  // Accent Colors - Green
  static const Color accentGreen = Color(0xFF27AE60);
  static const Color accentGreenDark = Color(0xFF1E8449);
  static const Color accentGreenLight = Color(0xFF52BE80);

  // Neutral Colors - Light Theme
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color mediumGray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF9E9E9E);
  static const Color charcoal = Color(0xFF424242);

  // Neutral Colors - Dark Theme
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);

  // Status Colors
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // Nutrition Colors (Macros)
  static const Color proteinColor = Color(0xFFE74C3C); // Red
  static const Color carbsColor = Color(0xFFF39C12);   // Orange
  static const Color fatColor = Color(0xFFFFD700);     // Gold

  // Additional Background Gradients
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [primaryOrange, primaryOrangeDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [accentGreen, accentGreenDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Light Theme Colors
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightBorder = Color(0xFFDEDEDE);

  // Dark Theme Colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFBDBDBD);
  static const Color darkBorder = Color(0xFF424242);
}
