import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  final analytics = FirebaseAnalytics.instance;

  Future<void> recordSignUp() async {
    await analytics.logSignUp(signUpMethod: "Custom token");
  }

  Future<void> recordAppOpen() async {
    await analytics.logAppOpen();
  }
}
