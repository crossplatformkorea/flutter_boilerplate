import 'package:flutter/material.dart';
import 'package:flutter_seoul/utils/router_config.dart';
import 'package:flutter_seoul/widgets/common/button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Views extends HookConsumerWidget {
  const Views({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Views'),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Button(
            onPress: () {
              context.go(
                  '${GoRoutes.views.fullPath}${GoRoutes.tabScroll.fullPath}');
            },
            text: 'tabView scroll',
          ),
          const SizedBox(height: 10),
          Button(
            onPress: () {
              context.go(
                  '${GoRoutes.views.fullPath}${GoRoutes.collapsibleTabScroll.fullPath}');
            },
            text: 'collapsible tabView scroll',
          ),
        ],
      ),
    );
  }
}
