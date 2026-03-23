import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';
import 'styles/credit_card_page_styles.dart';

class CreditCardPage extends StatelessWidget {
  const CreditCardPage({super.key});

  static final List<String> _months =
      List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));

  static final List<String> _years = List.generate(
    10,
    (index) => ((DateTime.now().year % 100) + index).toString().padLeft(2, '0'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CreditCardPageStyles.backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bloc = context.read<CardFormBloc>();
            final panelWidth =
                CreditCardPageStyles.panelWidthFor(constraints.maxWidth);
            final cardWidth = panelWidth * CreditCardPageStyles.cardWidthFactor;

            return BlocListener<CardFormBloc, CardFormState>(
              listenWhen: (previous, current) =>
                  previous.submissionCount != current.submissionCount,
              listener: (context, state) {
                final cardNumber =
                    state.lastSubmittedCardNumber ?? state.cardData.cardNumber;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Card submitted: $cardNumber'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              child: SingleChildScrollView(
                padding: CreditCardPageStyles.pagePadding,
                child: ConstrainedBox(
                  constraints:
                      CreditCardPageStyles.minHeight(constraints.maxHeight),
                  child: Center(
                    child: SizedBox(
                      width: panelWidth,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: CreditCardPageStyles.formPanelOffset,
                            child: CardFormSection(
                              months: _months,
                              years: _years,
                              panelTopPadding:
                                  CreditCardPageStyles.formPanelTopPadding,
                              onSubmit: bloc.submit,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Transform.translate(
                              offset: const Offset(0, -20),
                              child: SizedBox(
                                width: cardWidth,
                                child: BlocBuilder<CardFormBloc, CardFormState>(
                                  builder: (context, state) {
                                    return CreditCardDisplay(
                                      cardData: state.cardData,
                                      isFlipped: state.isFlipped,
                                      focusedField: state.focusedField,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
