import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../themes/form_fields_styles.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> onFocusChanged;
  final VoidCallback? onTap;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.keyboardType,
    this.maxLength = 50,
    required this.onChanged,
    required this.onFocusChanged,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.formLabel,
        ),
        const SizedBox(height: FormFieldsStyles.spacingAfterLabel),
        Focus(
          onFocusChange: onFocusChanged,
          child: TextField(
            keyboardType: keyboardType,
            maxLength: maxLength,
            textCapitalization: textCapitalization,
            style: AppTextStyles.inputText,
            onChanged: onChanged,
            onTap: onTap,
            inputFormatters: inputFormatters,
            decoration: FormFieldsStyles.decoration(hint),
          ),
        ),
      ],
    );
  }
}

class SmallFormField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final int maxLength;
  final bool isPassword;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> onFocusChanged;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;

  const SmallFormField({
    super.key,
    required this.hint,
    required this.keyboardType,
    this.maxLength = 50,
    this.isPassword = false,
    required this.onChanged,
    required this.onFocusChanged,
    this.onTap,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: onFocusChanged,
      child: TextField(
        keyboardType: keyboardType,
        maxLength: maxLength,
        obscureText: isPassword,
        style: AppTextStyles.inputText,
        onChanged: onChanged,
        onTap: onTap,
        inputFormatters: inputFormatters,
        decoration: FormFieldsStyles.decoration(hint),
      ),
    );
  }
}

class DropdownFormField extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onChanged;
  final String initialValue;
  final VoidCallback? onTap;

  const DropdownFormField({
    super.key,
    required this.items,
    required this.onChanged,
    required this.initialValue,
    this.onTap,
  });

  @override
  State<DropdownFormField> createState() => _DropdownFormFieldState();
}

class _DropdownFormFieldState extends State<DropdownFormField> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: FormFieldsStyles.dropdownHorizontalPadding,
      decoration: FormFieldsStyles.dropdownDecoration,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedValue,
          onTap: widget.onTap,
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: AppTextStyles.dropdownItem,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedValue = newValue;
              });
              widget.onChanged(newValue);
            }
          },
          dropdownColor: AppColors.white,
          iconEnabledColor: AppColors.textPrimary,
          style: AppTextStyles.dropdownItem,
          isExpanded: true,
        ),
      ),
    );
  }
}
