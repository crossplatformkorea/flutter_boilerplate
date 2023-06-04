import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_seoul/models/item_model.dart';
import 'package:flutter_seoul/navigations/main_bottom_tab.dart';
import 'package:flutter_seoul/providers/user_provider.dart';
import 'package:flutter_seoul/screens/edit_profile.dart';
import 'package:flutter_seoul/screens/home.dart';
import 'package:flutter_seoul/screens/item_detail.dart';
import 'package:flutter_seoul/screens/permission_screen.dart';
import 'package:flutter_seoul/screens/result.dart';
import 'package:flutter_seoul/screens/sample.dart';
import 'package:flutter_seoul/screens/sign_in.dart';
import 'package:flutter_seoul/screens/views/collapsible_tab_scroll.dart';
import 'package:flutter_seoul/screens/views/tab_scroll.dart';
import 'package:flutter_seoul/screens/views/views.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum GoRoutes {
  authSwitch,
  signIn,
  home,
  itemDetail,
  permission,
  views,
  tabScroll,
  collapsibleTabScroll,
  editProfile,
  sample,
  result
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 120),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

extension GoRoutesName on GoRoutes {
  String get name => describeEnum(this);

  /// Convert to `lower-snake-case` format.
  String get path {
    var exp = RegExp(r'(?<=[a-z])[A-Z]');
    var result =
        name.replaceAllMapped(exp, (m) => '-${m.group(0)}').toLowerCase();
    return result;
  }

  /// Convert to `lower-snake-case` format with `/`.
  String get fullPath {
    var exp = RegExp(r'(?<=[a-z])[A-Z]');
    var result =
        name.replaceAllMapped(exp, (m) => '-${m.group(0)}').toLowerCase();
    return '/$result';
  }
}

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: GoRoutes.home.fullPath,
      redirect: (context, state) {
        final currentUser = ref.read(userStateProvider);
        if (currentUser.value == null && currentUser.value!.isEmpty) {
          if (state.matchedLocation != GoRoutes.signIn.fullPath) {
            return GoRoutes.signIn.fullPath;
          }
        }
        return null;
      },
      routes: <RouteBase>[
        ShellRoute(
          builder: (context, state, child) => MainBottomTab(child: child),
          routes: [
            GoRoute(
              name: GoRoutes.home.name,
              path: GoRoutes.home.fullPath,
              pageBuilder: (context, state) =>
                  buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const Home(),
              ),
              routes: [
                GoRoute(
                  name: GoRoutes.itemDetail.name,
                  path: ':id',
                  builder: (context, state) {
                    final item = state.extra! as ItemModel;
                    return ItemDetail(item: item);
                  },
                ),
              ],
            ),
            GoRoute(
              name: GoRoutes.permission.name,
              path: GoRoutes.permission.fullPath,
              pageBuilder: (context, state) =>
                  buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const PermissionScreen(),
              ),
            ),
            GoRoute(
                name: GoRoutes.views.name,
                path: GoRoutes.views.fullPath,
                pageBuilder: (context, state) =>
                    buildPageWithDefaultTransition<void>(
                      context: context,
                      state: state,
                      child: const Views(),
                    ),
                routes: [
                  GoRoute(
                    name: GoRoutes.tabScroll.name,
                    path: 'tab-Scroll',
                    builder: (context, state) {
                      return const TabScroll();
                    },
                  ),
                  GoRoute(
                    name: GoRoutes.collapsibleTabScroll.name,
                    path: 'collapsible-Tab-Scroll',
                    builder: (context, state) {
                      return const CollapsibleTabScroll();
                    },
                  ),
                ]),
            GoRoute(
              name: GoRoutes.editProfile.name,
              path: GoRoutes.editProfile.fullPath,
              pageBuilder: (context, state) =>
                  buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const EditProfile(),
              ),
            ),
          ],
        ),
        GoRoute(
          name: GoRoutes.signIn.name,
          path: GoRoutes.signIn.fullPath,
          builder: (context, state) {
            return const SignIn();
          },
        ),
        GoRoute(
          name: GoRoutes.sample.name,
          path: GoRoutes.sample.fullPath,
          builder: (context, state) {
            return const Sample();
          },
        ),
        GoRoute(
          name: GoRoutes.result.name,
          path: GoRoutes.result.fullPath,
          builder: (context, state) {
            return const Result();
          },
        ),
      ],
    );
  },
);
