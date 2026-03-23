import 'package:flutter_test/flutter_test.dart';

import 'package:credit_card/main.dart';

void main() {
  testWidgets('renders the default form labels', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Card Number'), findsOneWidget);
    expect(find.text('Card Holder'), findsWidgets);
    expect(find.text('Submit'), findsOneWidget);
    expect(find.text('CVV'), findsWidgets);
  });
}
