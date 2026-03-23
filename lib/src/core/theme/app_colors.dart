import 'package:flutter/material.dart';

/// Central color palette for the app — Single Responsibility: colors only.
abstract final class AppColors {
  // Brand / Primary
  static const Color primary = Color(0xFF2D5BD4);
  static const Color primaryLight = Color(0xFF8EA6D6);

  // Background
  static const Color scaffoldBackground = Color(0xFFD6E8FA);
  static const Color cardBackground = Colors.white;
  static const Color inputFill = Color(0xFFF7F9FC);

  // Text
  static const Color textPrimary = Color(0xFF223146);
  static const Color textSecondary = Color(0xFF4B5566);

  // Border
  static const Color borderDefault = Color(0xFFD1D8E2);
  static const Color borderFocused = Color(0xFF8EA6D6);

  // Card surface
  static const Color cardOverlayLight = Color(0x33000000); // black 20%
  static const Color cardOverlayDark = Color(0xD9000000); // black 85%

  // Feedback
  static const Color success = Colors.green;
  static const Color white = Colors.white;
}
