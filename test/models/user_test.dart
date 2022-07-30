import 'package:flutter_boilerplate/models/user_model.dart';
import 'package:test/test.dart';

void main() {
  test('The User instance has a class variable called name', () {
    const user = UserModel(id: 'a', name: "Hyo");

    expect(user.name, "Hyo");
    expect(user.id, 'a');
  });
}
