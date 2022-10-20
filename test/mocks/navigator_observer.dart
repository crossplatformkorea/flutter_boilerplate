import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<NavigatorObserver>(
      onMissingStub: OnMissingStub.returnDefault,
    ),
  ],
)
void main() {}
