import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:flutter_boilerplate/widgets/responsive.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('It should have a mobile width.', (WidgetTester tester) async {
    var widget = TestUtils.buildMediaQueryTestableWidget(
        child: Container(), device: Device.mobile);

    await tester.pumpWidget(widget);

    final BuildContext context = tester.element(find.byType(Container));

    bool isMobile = Responsive.isMobile(context);
    expect(isMobile, true);
  });

  testWidgets('It should have a tablet width.', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue =
        const Size(tableMaxWith - 100, 1080);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      TestUtils.makeTestableWidget(
        child: Responsive(
          mobile: Container(),
          tablet: Container(),
          desktop: Container(),
        ),
      ),
    );

    await tester.pump();

    final BuildContext context = tester.element(
      find.byType(
        Container,
      ),
    );

    bool isTablet = Responsive.isTablet(context);
    expect(isTablet, true);

    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
  });

  testWidgets('It should have a desktop width.', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue =
        const Size(tableMaxWith + 100, 1080);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      TestUtils.makeTestableWidget(
        child: Responsive(
          mobile: Container(),
          tablet: Container(),
          desktop: Container(),
        ),
      ),
    );

    await tester.pump();

    final BuildContext context = tester.element(
      find.byType(
        Container,
      ),
    );

    bool isDesktop = Responsive.isDesktop(context);
    expect(isDesktop, true);

    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
  });
}
