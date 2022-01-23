import 'package:flutter_boilerplate/screens/result.dart';
import 'package:flutter_boilerplate/utils/localization.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('The Result screen needs to be rendered.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TestUtils.makeTestableWidget(
        child: const Result(),
      ),
    );
    await tester.pump();

    expect(find.text(t("RESULT")), findsOneWidget);
  });
}
