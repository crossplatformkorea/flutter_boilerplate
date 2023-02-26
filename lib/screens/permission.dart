import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Permission extends HookWidget {
  const Permission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission'),
      ),
    );
  }
}
