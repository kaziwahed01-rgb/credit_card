import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

abstract final class FormFieldsStyles {
  static const double spacingAfterLabel = 8;
  static const EdgeInsets inputContentPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 12,
  );

  static const EdgeInsets dropdownHorizontalPadding = EdgeInsets.symmetric(
    horizontal: 12,
  );

  static InputDecoration decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.inputHint,
      filled: true,
      fillColor: AppColors.inputFill,
      contentPadding: inputContentPadding,
      border: _border(AppColors.borderDefault),
      enabledBorder: _border(AppColors.borderDefault),
      focusedBorder: _border(AppColors.borderFocused, width: 1.5),
      counterText: '',
    );
  }

  static OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static BoxDecoration dropdownDecoration = BoxDecoration(
    color: AppColors.inputFill,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: AppColors.borderDefault),
  );
}
