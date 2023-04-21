import 'package:flutter/material.dart';
import 'package:flutter_seoul/repositories/user_repository.dart';
import 'package:flutter_seoul/utils/router_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../test_utils.dart';

class MockUserRepository extends Mock implements UserRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpRealRouterApp(
    String location,
    Widget Function(Widget child) builder, {
    bool isConnected = true,
  }) {
    // Logic to initialize my StateManagement with the
    // value of isConnected
    // ...

    return pumpWidget(
      builder(
        MaterialApp.router(
          routeInformationParser: routerConfig(location).routeInformationParser,
          routerDelegate: routerConfig(location).routerDelegate,
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Render authSwitch', (WidgetTester tester) async {
    // await tester.pumpWidget(const ProviderScope(child: MyApp()));

    await tester.pumpRealRouterApp(
      GoRoutes.authSwitch.fullPath,
      (child) => child,
      isConnected: false,
    );

    final mockUserRepository = MockUserRepository();
    when(mockUserRepository.getMe()).thenAnswer(
      (_) => Future.value([]),
    );
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
        TestUtils.makeTestableWidget(child: GoRoutes.home.fullPath));
    await tester.pump();
  });

  testWidgets('Button is present and triggers navigation after tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        TestUtils.makeTestableWidget(child: GoRoutes.signIn.fullPath));
    await tester.pump();
  });
}
