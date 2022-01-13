import 'package:flutter_boilerplate/models/user.dart';
import 'package:get/state_manager.dart';

class CountController extends GetxController {
  RxInt count = 0.obs;
  Rx<User> user = User('test').obs;

  void increase() => count.value++;

  void updateName() {
    user(User('test2'));
  }
}
