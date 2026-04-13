import 'package:flutter_test/flutter_test.dart';

import 'package:pathly/main.dart';

void main() {
  testWidgets('home page shows Record and Replay buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PathlyApp());

    expect(find.text('Record'), findsOneWidget);
    expect(find.text('Replay'), findsOneWidget);
  });
}
