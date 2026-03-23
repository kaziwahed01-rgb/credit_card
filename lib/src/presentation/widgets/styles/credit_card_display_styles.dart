import 'package:flutter/material.dart';

abstract final class CreditCardDisplayStyles {
  static const double cardHeight = 190;
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(14));

  static final BoxDecoration cardShadowDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(14),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.26),
        blurRadius: 22,
        offset: const Offset(0, 12),
      ),
    ],
  );

  static BoxDecoration fieldFocusDecoration(double radius) {
    return BoxDecoration(
      border: Border.all(color: Colors.black, width: 1.5),
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.55),
          blurRadius: 6,
          spreadRadius: 0.5,
          offset: Offset.zero,
        ),
      ],
    );
  }

  static Color frontOverlay = Colors.black.withValues(alpha: 0.34);
  static Color backOverlay = Colors.black.withValues(alpha: 0.18);
  static Color magneticStripe = Colors.black.withValues(alpha: 0.85);

  static const double focusHorizontalInset = 14;
  static const double numberFocusTop = 78;
  static const double numberFocusHeight = 34;
  static const double cardNumberFocusRadius = 4;
  static const double bottomFieldFocusRadius = 6;
  static const double bottomFocusInset = 20;
  static const double bottomFieldFocusHeight = 38;
  static const double focusHorizontalPadding = 8;
  static const double focusVerticalPadding = 5;

  static const double holderFocusMaxWidthFactor = 0.58;
  static const double expiryFocusMaxWidthFactor = 0.36;
  static const double holderTextMaxWidthFactor = 0.52;

  static const EdgeInsets frontPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 14,
  );
  static const EdgeInsets backPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 14,
  );
}
