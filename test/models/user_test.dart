import 'package:test/test.dart';
import 'package:flutter_boilerplate/models/user.dart';

void main() {
  test('The User instance has a class variable called name', () {
    const user = User(name: "Hyo");
    expect(user.name, "Hyo");
  });
}
