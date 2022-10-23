import 'package:flutter_boilerplate/screens/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: const Home()));
    await tester.pump();

    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Button is present and triggers navigation after tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: const Home()));
    await tester.pump();

    // var buttons = find.byType(TextButton);

    // expect(buttons, findsNWidgets(2));

    // await tester.tap(buttons.first);
    // await tester.pumpAndSettle();

    // expect(find.byType(Result), findsOneWidget);
  });
}
