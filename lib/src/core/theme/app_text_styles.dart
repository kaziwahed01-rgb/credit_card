import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Central text-style catalogue — Single Responsibility: typography only.
abstract final class AppTextStyles {
  // ── Form labels ──────────────────────────────────────────────────────────
  static const TextStyle formLabel = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 11,
  );

  // ── Input text ───────────────────────────────────────────────────────────
  static const TextStyle inputText = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
  );

  static const TextStyle inputHint = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
  );

  // ── Button ───────────────────────────────────────────────────────────────
  static const TextStyle submitButton = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // ── Card face ────────────────────────────────────────────────────────────
  static const TextStyle cardNumber = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static const TextStyle cardLabel = TextStyle(
    color: Color(0xB3FFFFFF), // white 70%
    fontSize: 10,
  );

  static const TextStyle cardValue = TextStyle(
    color: AppColors.white,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle cardExpiry = TextStyle(
    color: AppColors.white,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  // ── Card back ────────────────────────────────────────────────────────────
  static const TextStyle cvvLabel = TextStyle(
    color: Color(0xE5FFFFFF), // white 90%
    fontSize: 11,
  );

  static const TextStyle cvvValue = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  static const TextStyle cvvPlaceholder = TextStyle(
    color: Colors.grey,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  // ── Dropdown ─────────────────────────────────────────────────────────────
  static const TextStyle dropdownItem = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
  );
}
