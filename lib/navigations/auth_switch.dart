import 'package:flutter/material.dart';
import 'package:flutter_seoul/navigations/main_bottom_tab.dart';
import 'package:flutter_seoul/screens/sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repositories/user_repository.dart';
import '../widgets/common/loading_indicator.dart';

class AuthSwitch extends ConsumerWidget {
  const AuthSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: UserRepository.instance.getMe(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          var currentUser = snap.data;
          if (currentUser == null) {
            return const SignIn();
          }

          var user = snap.data;

          if (snap.hasData && user != null) {
            return const MainBottomTab();
          }

          return const MainBottomTab();
        }

        return const Scaffold(
          body: LoadingIndicator(),
        );
      },
    );
  }
}
