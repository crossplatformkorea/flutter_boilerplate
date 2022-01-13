import 'package:flutter_boilerplate/models/user.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController {
  Rx<User> user = User(name: 'test').obs;

  void updateName() {
    user.update((user) {
      user?.name = 'test2';
    });

    // or you can do this.
    // user(User(name: 'test2'));
  }
}
