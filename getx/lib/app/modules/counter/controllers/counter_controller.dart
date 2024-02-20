import 'package:get/get.dart';

class CounterController extends GetxController {
  //TODO: Implement CounterController

  final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @overrideA
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;

  void increment() {
    count.value++;
  }
}
