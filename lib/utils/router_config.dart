import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_seoul/screens/edit_profile.dart';
import 'package:flutter_seoul/screens/home.dart';
import 'package:flutter_seoul/screens/result.dart';
import 'package:flutter_seoul/screens/sample.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum GoRoutes { home, editProfile, sample, result }

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

final routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: GoRoutes.home.fullPath,
  errorBuilder: (context, state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text('Error: ${state.error}'),
    );
  },
  routes: <RouteBase>[
    GoRoute(
      name: GoRoutes.home.name,
      path: GoRoutes.home.fullPath,
      builder: (context, state) {
        return const Home();
      },
    ),
    GoRoute(
      name: GoRoutes.editProfile.name,
      path: GoRoutes.editProfile.fullPath,
      builder: (context, state) {
        var args = state.extra as EditProfileArugments;

        return EditProfile(
          title: args.title,
          person: args.person,
        );
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
