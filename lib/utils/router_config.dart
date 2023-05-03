import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_seoul/models/item_model.dart';
import 'package:flutter_seoul/navigations/main_bottom_tab.dart';
import 'package:flutter_seoul/screens/edit_profile.dart';
import 'package:flutter_seoul/screens/home.dart';
import 'package:flutter_seoul/screens/item_detail.dart';
import 'package:flutter_seoul/screens/permission_screen.dart';
import 'package:flutter_seoul/screens/result.dart';
import 'package:flutter_seoul/screens/sample.dart';
import 'package:flutter_seoul/screens/sign_in.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum GoRoutes {
  authSwitch,
  signIn,
  home,
  permission,
  itemDetail,
  editProfile,
  sample,
  result
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

GoRouter routerConfig([String? initialLocation]) => GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: initialLocation ?? GoRoutes.home.fullPath,
      routes: <RouteBase>[
        ShellRoute(
          builder: (context, state, child) => MainBottomTab(child: child),
          routes: [
            GoRoute(
              name: GoRoutes.home.name,
              path: GoRoutes.home.fullPath,
              builder: (context, state) {
                return const Home();
              },
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
              builder: (context, state) {
                return const PermissionScreen();
              },
            ),
            GoRoute(
              name: GoRoutes.editProfile.name,
              path: GoRoutes.editProfile.fullPath,
              builder: (context, state) {
                return const EditProfile();
              },
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
