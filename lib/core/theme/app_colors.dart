import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Cinema Red
  static const Color primary = Color(0xFFE50914);
  static const Color primaryDark = Color(0xFFB81D24);
  static const Color primaryLight = Color(0xFFFF3D47);

  // Accent Gold (rating, favorite)
  static const Color accent = Color(0xFFFFC107);
  static const Color accentDark = Color(0xFFFFA000);

  // Dark Theme Surfaces
  static const Color bgDark = Color(0xFF0A0A0F);
  static const Color surfaceDark = Color(0xFF14141B);
  static const Color surfaceDark2 = Color(0xFF1C1C26);
  static const Color surfaceDark3 = Color(0xFF24242F);
  static const Color borderDark = Color(0xFF2A2A36);

  // Light Theme Surfaces
  static const Color bgLight = Color(0xFFF8F8FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceLight2 = Color(0xFFF0F0F4);
  static const Color borderLight = Color(0xFFE0E0E6);

  // Text — Dark
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB3B3BB);
  static const Color textMutedDark = Color(0xFF6E6E78);

  // Text — Light
  static const Color textPrimaryLight = Color(0xFF14141B);
  static const Color textSecondaryLight = Color(0xFF4A4A55);
  static const Color textMutedLight = Color(0xFF8E8E98);

  // Semantic
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF2196F3);

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0xCC0A0A0F),
      Color(0xFF0A0A0F),
    ],
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF14141B),
      Color(0xFF0A0A0F),
      Color(0xFF1C0008),
    ],
  );

  static const LinearGradient cardShine = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x33FFFFFF),
      Color(0x0DFFFFFF),
      Color(0x00FFFFFF),
    ],
  );
}
