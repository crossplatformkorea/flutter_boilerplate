import 'package:test/test.dart';
import 'package:flutter_seoul/models/user_model.dart';

void main() {
  test('The User instance has a class variable called name', () {
    const user =
        UserModel(organization: 'dooboolab', age: 30, displayName: 'Hyo');
    expect(user.displayName, 'Hyo');
  });
}
