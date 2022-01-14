import 'package:get/state_manager.dart';

class CountController extends GetxController {
  RxInt count = 0.obs;

  void increase() => count.value++;
}
