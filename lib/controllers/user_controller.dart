import 'package:flutter_boilerplate/models/user.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController {
  Rx<User> user =
      const User(displayName: 'test', age: 30, organization: 'dooboolab').obs;

  void updateName() {
    user(const User(displayName: 'test2', age: 40, organization: 'dooboolab'));
  }
}
