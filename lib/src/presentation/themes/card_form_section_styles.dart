import 'package:flutter/material.dart';
import 'themes.dart';

abstract final class CardFormSectionStyles {
  static EdgeInsets panelPadding(double panelTopPadding) =>
      EdgeInsets.fromLTRB(18, panelTopPadding, 18, 18);

  static final BoxDecoration panelDecoration = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.12),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static const SizedBox fieldGap = SizedBox(height: 14);
  static const SizedBox submitGap = SizedBox(height: 24);
  static const SizedBox expiryGap = SizedBox(width: 8);
  static const SizedBox sectionGap = SizedBox(width: 14);

  static const double submitHeight = 50;

  static ButtonStyle submitButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  );
}
