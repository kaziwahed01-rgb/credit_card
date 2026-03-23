import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../domain/entities/credit_card_entity.dart';
import 'card_form_event.dart';
import 'card_form_state.dart';

class CardFormBloc extends Bloc<CardFormEvent, CardFormState> {
  CardFormBloc()
      : super(
          CardFormState(
            cardData: const CreditCardEntity(
              cardNumber: '4323 3445 5677 8886',
              cardHolder: '',
              expirationMonth: '08',
              expirationYear: '30',
              cvv: '',
              isFlipped: false,
            ),
          ),
        ) {
    on<CardFormChanged>(_onChanged);
    on<CardFormSubmitted>(_onSubmitted);
  }

  void updateCardNumber(String value) {
    add(CardFormChanged(
        cardNumber: value, focusedField: CardFormField.cardNumber));
  }

  void updateCardHolder(String value) {
    add(CardFormChanged(
        cardHolder: value, focusedField: CardFormField.cardHolder));
  }

  void updateExpirationMonth(String value) {
    add(CardFormChanged(
        expirationMonth: value, focusedField: CardFormField.expiry));
  }

  void updateExpirationYear(String value) {
    add(CardFormChanged(
        expirationYear: value, focusedField: CardFormField.expiry));
  }

  void updateCvv(String value) {
    add(CardFormChanged(cvv: value, focusedField: CardFormField.cvv));
  }

  void focusField(CardFormField? field) {
    add(CardFormChanged(focusedField: field));
  }

  void submit() {
    add(const CardFormSubmitted());
  }

  void _onChanged(CardFormChanged event, Emitter<CardFormState> emit) {
    final sanitizedCardNumber =
        _digitsOnly(event.cardNumber)?.substring(0, _safeLength(event.cardNumber, 16));
    final sanitizedCardHolder =
        event.cardHolder?.replaceAll(RegExp(r'[^a-zA-Z ]'), '');
    final sanitizedCvv =
        _digitsOnly(event.cvv)?.substring(0, _safeLength(event.cvv, 3));

    emit(
      state.copyWith(
        cardData: state.cardData.copyWith(
          cardNumber: sanitizedCardNumber != null
              ? CardValidationUtils.formatCardNumber(sanitizedCardNumber)
              : state.cardData.cardNumber,
          cardHolder: sanitizedCardHolder != null
              ? CardValidationUtils.formatCardHolder(sanitizedCardHolder)
              : state.cardData.cardHolder,
          expirationMonth:
              event.expirationMonth ?? state.cardData.expirationMonth,
          expirationYear: event.expirationYear ?? state.cardData.expirationYear,
          cvv: sanitizedCvv ?? state.cardData.cvv,
          isFlipped: false,
        ),
        focusedField: event.focusedField,
      ),
    );
  }

  void _onSubmitted(CardFormSubmitted event, Emitter<CardFormState> emit) {
    emit(
      state.copyWith(
        submissionCount: state.submissionCount + 1,
        lastSubmittedCardNumber: state.cardData.cardNumber,
      ),
    );
  }

  String? _digitsOnly(String? value) {
    return value?.replaceAll(RegExp(r'[^0-9]'), '');
  }

  int _safeLength(String? value, int maxLength) {
    final cleanedLength = _digitsOnly(value)?.length ?? 0;
    return cleanedLength > maxLength ? maxLength : cleanedLength;
  }
}
