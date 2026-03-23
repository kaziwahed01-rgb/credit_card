import 'package:equatable/equatable.dart';

import 'card_form_state.dart';

abstract class CardFormEvent extends Equatable {
  const CardFormEvent();

  @override
  List<Object?> get props => [];
}

class CardFormChanged extends CardFormEvent {
  const CardFormChanged({
    this.cardNumber,
    this.cardHolder,
    this.expirationMonth,
    this.expirationYear,
    this.cvv,
    this.focusedField = focusedFieldUnchanged,
  });

  final String? cardNumber;
  final String? cardHolder;
  final String? expirationMonth;
  final String? expirationYear;
  final String? cvv;
  final Object? focusedField;

  @override
  List<Object?> get props => [
        cardNumber,
        cardHolder,
        expirationMonth,
        expirationYear,
        cvv,
        focusedField,
      ];
}

class CardFormSubmitted extends CardFormEvent {
  const CardFormSubmitted();
}
