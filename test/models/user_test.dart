import 'package:test/test.dart';
import 'package:flutter_boilerplate/models/user.dart';

void main() {
  test('Counter value should be incremented', () {
    final user = User(name: "Hyo");
    expect(user.name, "Hyo");
  });
}
