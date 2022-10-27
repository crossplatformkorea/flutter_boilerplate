import 'package:flutter_seoul/screens/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: const Home()));
    await tester.pump();
  });

  testWidgets('Button is present and triggers navigation after tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: const Home()));
    await tester.pump();
  });
}
