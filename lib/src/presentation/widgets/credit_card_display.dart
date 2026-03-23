import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../bloc/card_form_state.dart';
import 'animated_text_widget.dart';
import 'styles/credit_card_display_styles.dart';

class CreditCardDisplay extends StatelessWidget {
  const CreditCardDisplay({
    super.key,
    required this.cardData,
    required this.isFlipped,
    this.focusedField,
  });

  final CreditCardEntity cardData;
  final bool isFlipped;
  final CardFormField? focusedField;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: isFlipped ? 1 : 0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        final angle = value * math.pi;
        final showBack = value > 0.5;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: showBack
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..setEntry(0, 0, -1),
                  child: CardBackWidget(cardData: cardData),
                )
              : CardFrontWidget(
                  cardData: cardData,
                  focusedField: focusedField,
                ),
        );
      },
    );
  }
}

class CardFrontWidget extends StatelessWidget {
  const CardFrontWidget({
    super.key,
    required this.cardData,
    this.focusedField,
  });

  final CreditCardEntity cardData;
  final CardFormField? focusedField;

  double _textWidth(BuildContext context, String text, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: Directionality.of(context),
    )..layout();
    return painter.width;
  }

  Rect _bottomFocusRect({
    required double cardWidth,
    required double textWidth,
    required bool alignRight,
    required double maxWidth,
  }) {
    final width =
        (textWidth + (CreditCardDisplayStyles.focusHorizontalPadding * 2))
            .clamp(84.0, maxWidth);
    final height = CreditCardDisplayStyles.bottomFieldFocusHeight;
    final top = CreditCardDisplayStyles.cardHeight -
        CreditCardDisplayStyles.bottomFocusInset -
        height;
    final left = alignRight
        ? cardWidth - CreditCardDisplayStyles.focusHorizontalInset - width
        : CreditCardDisplayStyles.focusHorizontalInset;

    return Rect.fromLTWH(left, top + 10, width, height);
  }

  double _focusBorderRadius() {
    if (focusedField == CardFormField.cardHolder ||
        focusedField == CardFormField.expiry) {
      return CreditCardDisplayStyles.bottomFieldFocusRadius;
    }

    return CreditCardDisplayStyles.cardNumberFocusRadius;
  }

  Rect? _focusRect(BuildContext context, double cardWidth) {
    if (focusedField == CardFormField.cardNumber) {
      return Rect.fromLTWH(
        CreditCardDisplayStyles.focusHorizontalInset,
        CreditCardDisplayStyles.numberFocusTop,
        cardWidth - (CreditCardDisplayStyles.focusHorizontalInset * 2),
        CreditCardDisplayStyles.numberFocusHeight,
      );
    }

    if (focusedField == CardFormField.cardHolder) {
      final holderText =
          cardData.cardHolder.isEmpty ? 'CARDHOLDER' : cardData.cardHolder;
      return _bottomFocusRect(
        cardWidth: cardWidth,
        textWidth: _textWidth(context, holderText, AppTextStyles.cardValue),
        alignRight: false,
        maxWidth: cardWidth * CreditCardDisplayStyles.holderFocusMaxWidthFactor,
      );
    }

    if (focusedField == CardFormField.expiry) {
      final expiryText =
          '${cardData.expirationMonth}/${cardData.expirationYear}';
      return _bottomFocusRect(
        cardWidth: cardWidth,
        textWidth: _textWidth(context, expiryText, AppTextStyles.cardExpiry),
        alignRight: true,
        maxWidth: cardWidth * CreditCardDisplayStyles.expiryFocusMaxWidthFactor,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CreditCardDisplayStyles.cardHeight,
      decoration: CreditCardDisplayStyles.cardShadowDecoration,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final focusRect = _focusRect(context, constraints.maxWidth);
          final holderTextMaxWidth = constraints.maxWidth *
              CreditCardDisplayStyles.holderTextMaxWidthFactor;

          return Stack(
            children: [
              ClipRRect(
                borderRadius: CreditCardDisplayStyles.cardRadius,
                child: Container(
                  color: Colors.grey[800],
                  child: Image.asset(
                    'assets/1.jpeg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: CreditCardDisplayStyles.cardRadius,
                child: Container(color: CreditCardDisplayStyles.frontOverlay),
              ),
              if (focusRect != null)
                Positioned.fromRect(
                  rect: focusRect,
                  child: Container(
                    decoration: CreditCardDisplayStyles.fieldFocusDecoration(
                      _focusBorderRadius(),
                    ),
                  ),
                ),
              ClipRRect(
                borderRadius: CreditCardDisplayStyles.cardRadius,
                child: Padding(
                  padding: CreditCardDisplayStyles.frontPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/chip.png',
                            width: 42,
                            height: 32,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 50,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Center(
                                  child: Text(
                                    'CHIP',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Image.asset(
                            'assets/visa.png',
                            width: 56,
                            height: 26,
                            errorBuilder: (context, error, stackTrace) {
                              return const Text(
                                'VISA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: AnimatedTextWidget(
                          text: cardData.cardNumber,
                          style: AppTextStyles.cardNumber,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Card Holder',
                                style: AppTextStyles.cardLabel,
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: holderTextMaxWidth,
                                child: Text(
                                  cardData.cardHolder.isEmpty
                                      ? 'CARDHOLDER'
                                      : cardData.cardHolder,
                                  style: AppTextStyles.cardValue,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Expiry',
                                style: AppTextStyles.cardLabel,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${cardData.expirationMonth}/${cardData.expirationYear}',
                                style: AppTextStyles.cardExpiry,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CardBackWidget extends StatelessWidget {
  const CardBackWidget({
    super.key,
    required this.cardData,
  });

  final CreditCardEntity cardData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CreditCardDisplayStyles.cardHeight,
      decoration: CreditCardDisplayStyles.cardShadowDecoration,
      child: ClipRRect(
        borderRadius: CreditCardDisplayStyles.cardRadius,
        child: Stack(
          children: [
            Image.asset(
              'assets/1.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(color: CreditCardDisplayStyles.backOverlay),
            Padding(
              padding: CreditCardDisplayStyles.backPadding,
              child: Column(
                children: [
                  Container(
                    height: 28,
                    color: CreditCardDisplayStyles.magneticStripe,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'CVV',
                      style: AppTextStyles.cvvLabel,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedTextWidget(
                        text: CardValidationUtils.maskCvv(cardData.cvv),
                        style: cardData.cvv.isEmpty
                            ? AppTextStyles.cvvPlaceholder
                            : AppTextStyles.cvvValue,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/visa.png',
                      width: 56,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text(
                          'VISA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
