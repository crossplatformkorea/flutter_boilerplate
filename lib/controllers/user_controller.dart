import 'package:flutter_boilerplate/models/user.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController {
  Rx<User> user = const User(name: 'test').obs;

  void updateName() {
    user(const User(name: 'test2'));
  }
}
