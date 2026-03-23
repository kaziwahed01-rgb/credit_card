import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

abstract final class CreditCardPageStyles {
  static const Color backgroundColor = AppColors.scaffoldBackground;
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 20,
  );

  static const EdgeInsets formPanelOffset = EdgeInsets.only(top: 78);
  static const double formPanelTopPadding = 96;

  static const double desktopBreakpoint = 900;
  static const double panelMaxWidth = 380;
  static const double panelMinWidth = 320;
  static const double panelHorizontalPadding = 28;
  static const double cardWidthFactor = 0.84;

  static BoxConstraints minHeight(double maxHeight) =>
      BoxConstraints(minHeight: maxHeight - 40);

  static double panelWidthFor(double maxWidth) {
    if (maxWidth >= desktopBreakpoint) {
      return panelMaxWidth;
    }
    return (maxWidth - panelHorizontalPadding)
        .clamp(panelMinWidth, panelMaxWidth);
  }
}
