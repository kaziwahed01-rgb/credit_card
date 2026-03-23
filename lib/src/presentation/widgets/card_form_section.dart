import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';
import '../bloc/bloc.dart';
import 'form_fields.dart';
import 'styles/card_form_section_styles.dart';

class CardFormSection extends StatelessWidget {
  const CardFormSection({
    super.key,
    required this.months,
    required this.years,
    this.panelTopPadding = 0,
    required this.onSubmit,
  });

  final List<String> months;
  final List<String> years;
  final double panelTopPadding;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CardFormBloc>();

    return Container(
      padding: CardFormSectionStyles.panelPadding(panelTopPadding),
      decoration: CardFormSectionStyles.panelDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomFormField(
            label: 'Card Number',
            hint: '4323 3445 5677 8886',
            keyboardType: TextInputType.number,
            maxLength: 16,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
            ],
            onChanged: bloc.updateCardNumber,
            onTap: () => bloc.focusField(CardFormField.cardNumber),
            onFocusChanged: (hasFocus) => bloc.focusField(
              hasFocus ? CardFormField.cardNumber : null,
            ),
          ),
          CardFormSectionStyles.fieldGap,
          CustomFormField(
            label: 'Card Holder',
            hint: 'DEMO USER',
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ]")),
            ],
            onChanged: bloc.updateCardHolder,
            onTap: () => bloc.focusField(CardFormField.cardHolder),
            onFocusChanged: (hasFocus) => bloc.focusField(
              hasFocus ? CardFormField.cardHolder : null,
            ),
            textCapitalization: TextCapitalization.words,
          ),
          CardFormSectionStyles.fieldGap,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiration Date',
                      style: AppTextStyles.formLabel,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownFormField(
                            items: months,
                            onTap: () => bloc.focusField(CardFormField.expiry),
                            onChanged: bloc.updateExpirationMonth,
                            initialValue: bloc.state.cardData.expirationMonth,
                          ),
                        ),
                        CardFormSectionStyles.expiryGap,
                        Expanded(
                          child: DropdownFormField(
                            items: years,
                            onTap: () => bloc.focusField(CardFormField.expiry),
                            onChanged: bloc.updateExpirationYear,
                            initialValue: bloc.state.cardData.expirationYear,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CardFormSectionStyles.sectionGap,
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CVV',
                      style: AppTextStyles.formLabel,
                    ),
                    const SizedBox(height: 8),
                    SmallFormField(
                      hint: '213',
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      isPassword: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onChanged: bloc.updateCvv,
                      onTap: () => bloc.focusField(CardFormField.cvv),
                      onFocusChanged: (hasFocus) => bloc.focusField(
                        hasFocus ? CardFormField.cvv : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CardFormSectionStyles.submitGap,
          SubmitButton(onPressed: onSubmit),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CardFormSectionStyles.submitHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: CardFormSectionStyles.submitButtonStyle,
        child: Text(
          'Submit',
          style: AppTextStyles.submitButton,
        ),
      ),
    );
  }
}
