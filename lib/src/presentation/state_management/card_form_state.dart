import 'package:equatable/equatable.dart';

import '../../domain/entities/credit_card_entity.dart';

enum CardFormField { cardNumber, cardHolder, expiry, cvv }

const Object focusedFieldUnchanged = Object();

class CardFormState extends Equatable {
  const CardFormState({
    required this.cardData,
    this.submissionCount = 0,
    this.lastSubmittedCardNumber,
    this.focusedField,
  });

  final CreditCardEntity cardData;
  final int submissionCount;
  final String? lastSubmittedCardNumber;
  final CardFormField? focusedField;

  bool get isFlipped => focusedField == CardFormField.cvv;

  @override
  List<Object?> get props => [
        cardData,
        submissionCount,
        lastSubmittedCardNumber,
        focusedField,
      ];

  CardFormState copyWith({
    CreditCardEntity? cardData,
    int? submissionCount,
    String? lastSubmittedCardNumber,
    Object? focusedField = focusedFieldUnchanged,
  }) {
    return CardFormState(
      cardData: cardData ?? this.cardData,
      submissionCount: submissionCount ?? this.submissionCount,
      lastSubmittedCardNumber:
          lastSubmittedCardNumber ?? this.lastSubmittedCardNumber,
      focusedField: identical(focusedField, focusedFieldUnchanged)
          ? this.focusedField
          : focusedField as CardFormField?,
    );
  }
}
