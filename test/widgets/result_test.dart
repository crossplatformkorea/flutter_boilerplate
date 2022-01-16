import 'package:flutter_boilerplate/screens/result.dart';
import 'package:flutter_boilerplate/utils/localization.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: const Result()));
    await tester.pump();

    // Verify that our counter starts at 0.
    expect(find.text(t("RESULT")), findsOneWidget);
  });
}
