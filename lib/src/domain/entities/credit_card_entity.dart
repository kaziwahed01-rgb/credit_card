import 'package:equatable/equatable.dart';

class CreditCardEntity extends Equatable {
  final String cardNumber;
  final String cardHolder;
  final String expirationMonth;
  final String expirationYear;
  final String cvv;
  final bool isFlipped;

  const CreditCardEntity({
    required this.cardNumber,
    required this.cardHolder,
    required this.expirationMonth,
    required this.expirationYear,
    required this.cvv,
    required this.isFlipped,
  });

  @override
  List<Object?> get props => [
        cardNumber,
        cardHolder,
        expirationMonth,
        expirationYear,
        cvv,
        isFlipped,
      ];

  CreditCardEntity copyWith({
    String? cardNumber,
    String? cardHolder,
    String? expirationMonth,
    String? expirationYear,
    String? cvv,
    bool? isFlipped,
  }) {
    return CreditCardEntity(
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolder: cardHolder ?? this.cardHolder,
      expirationMonth: expirationMonth ?? this.expirationMonth,
      expirationYear: expirationYear ?? this.expirationYear,
      cvv: cvv ?? this.cvv,
      isFlipped: isFlipped ?? this.isFlipped,
    );
  }
}
