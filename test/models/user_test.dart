import 'package:test/test.dart';
import 'package:flutter_seoul/models/user.dart';

void main() {
  test('The User instance has a class variable called name', () {
    const user = User(organization: 'dooboolab', age: 30, displayName: 'Hyo');
    expect(user.displayName, 'Hyo');
  });
}
